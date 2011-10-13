require "aws/cli/base"
require "ebs"

module EBS
  module CLI
    class Main < AWS::CLI::Base
      namespace "ebs"

      desc "check-dns-availability NAME", "Checks if the specified CNAME is available"
      def check_dns_availability(name)
        if account.check_dns_availability?(name)
          say "'#{name}' is available"
          exit 0
        else
          say "'#{name}' is not available"
          exit 1
        end
      end

      desc "create-application APP", ""
      method_option :description, type: :string
      def create_application(app)
        account.create_application!(app, options.dup)
      end

      desc "create-application-version APP VERSION", ""
      method_option :description, type: :string
      method_option :s3_bucket, type: :string
      method_option :s3_key, type: :string
      method_option :war, type: :string
      def create_application_version(app, version)
        if options[:war]
          # TODO: upload war
          options[:s3_bucket] = nil
          options[:s3_key] = nil
        end

        account.create_application_version!(app, version, options.dup)
      end

      desc "create-environment NAME", ""
      can_tableize_output
      can_wait_until_available
      method_option :JDBC, aliases: "-J", type: :string, desc: ""
      (:PARAM1..:PARAM5).zip("-P1".."-P5").each do |param, aliases|
        method_option param, aliases: aliases, type: :string, desc: ""
      end
      method_option :application, aliases: "-a", required: true, type: :string
      method_option :cname, aliases: "-c", type: :string
      method_option :description, aliases: "-d", type: :string
      method_option :key, aliases: "-k", type: :string
      method_option :stack, aliases: "-s", type: :string
      method_option :template, aliases: "-T", type: :string
      method_option :type, aliases: "-t", type: :string
      method_option :version, aliases: "-v", required: true, type: :string
      def create_environment(name)
        unless options[:stack] or options[:template]
          raise Error, "No value provided for options '--stack' or '--template'. " \
                       "Use --list-available-solution-stacks to see available stacks."
        end

        environment = account.create_environment!(name, options.dup).CreateEnvironmentResult
        tablize_environments([environment]).print

        wait_until_available(environment) do
          result = account.describe_environments!(:environment_ids => [environment.EnvironmentId]).DescribeEnvironmentsResult
          result.Environments.first
        end
      end

      desc "describe-application-versions [APPLICATION]", ""
      can_tableize_output
      def describe_application_versions(application = nil)
        result = account.describe_application_versions!(application, options.dup).DescribeApplicationVersionsResult

        table do
          header "ApplicationName", "DateCreated", "DateUpdated", "Description", "S3Bucket", "S3Key", "VersionLabel"

          result.ApplicationVersions.each do |v|
            row v.ApplicationName, v.DateCreated, v.DateUpdated, v.Description, v.SourceBundle.S3Bucket,
                v.SourceBundle.S3Key, v.VersionLabel
          end
        end.print
      end

      desc "describe-applications", ""
      can_tableize_output
      def describe_applications
        result = account.describe_applications!(options.dup).DescribeApplicationsResult
        table do
          header "ApplicationName", "ConfigurationTemplates", "DateCreated", "DateUpdated", "Description", "Versions"

          result.Applications.each do |a|
            row a.ApplicationName, a.ConfigurationTemplates, a.DateCreated, a.DateUpdated, a.Description,
                a.Versions.join(",")
          end
        end.print
      end

      desc "describe-environments", ""
      def describe_environments
        result = account.describe_environments!(options.dup).DescribeEnvironmentsResult
        tablize_environments(result.Environments).print
      end

      desc "describe-configuration-options", ""
      method_option :options, aliases: "-o", banner: "namespace:name namespace:name", type: :array
      def describe_configuration_options
        options = options().dup
        options[:options] = options_to_array_of_hashes(options)

        result = account.describe_configuration_options!(options).DescribeConfigurationOptionsResult

        puts result.SolutionStackName

        table do
          header "ChangeSeverity", "DefaultValue", "MaxLength", "MaxValue", "MinValue", "Name", "Namespace", "RegexLabel",
                 "RegexPattern", "UserDefined", "ValueOptions", "ValueType"

          result.Options.each do |o|
            row o.ChangeSeverity, o.DefaultValue, o.MaxLength, o.MaxValue, o.MinValue, o.Name, o.Namespace, o.Regex.Label,
                o.Regex.Pattern, o.UserDefined, o.ValueOptions.join(","), o.ValueType
          end
        end.print
      end

      desc "list-available-solution-stacks", ""
      def list_available_solution_stacks
        result = account.list_available_solution_stacks!.ListAvailableSolutionStacksResult
        puts result.SolutionStacks
      end

      protected
        def account
          EBS::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def options_to_array_of_hashes(options)
          if options[:options]
            options[:options].map { |option| Hash[[:namespace, :name].zip(option.split(":"))] }
          end
        end

        def tablize_environments(environments)
          table do
            header "ApplicationName", "CNAME", "Description", "EndpointURL", "EnvironmentId", "EnvironmentName", "Health",
                   "SolutionStackName", "Status", "TemplateName", "VersionLabel"
            environments.each do |e|
              row e.ApplicationName, e.CNAME, e.Description, e.EndpointURL, e.EnvironmentId, e.EnvironmentName, e.Health,
                  e.SolutionStackName, e.Status, e.TemplateName, e.VersionLabel
            end
          end
        end
    end
  end
end
