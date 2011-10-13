module EBS
  class Account < AWS::Account
    require "ebs/account/configuration_settings_mapping"

    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery
    include ConfigurationSettingsMapping

    DEFAULT_OPTIONS = { endpoint: "https://elasticbeanstalk.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2010-12-01"

    def check_dns_availability(name, options = {})
      auto "Action" => "CheckDNSAvailability", "CNAMEPrefix" => name
    end
    bang :check_dns_availability

    def check_dns_availability?(*args)
      check_dns_availability!(*args).CheckDNSAvailabilityResult.Available?
    end

    def create_application(app, options = {})
      auto "Action" => "CreateApplication", "ApplicationName" => app do
        option["Description"] = options[:description]
      end
    end
    bang :create_application

    def create_application_version(app, version, options = {})
      auto "Action" => "CreateApplicationVersion", "ApplicationName" => app, "VersionLabel" => version do
        option["AutoCreateApplication"] = options[:auto_create_application]
        option["Description"] = options[:description]
        hash["SourceBundle", "S3Bucket" => :s3_bucket, "S3Key" => :s3_key] = options
      end
    end
    bang :create_application_version

    def create_configuration_template(options = {})
    end
    bang :create_configuration_template

    def create_environment(name, options = {})
      settings = map_configuration_settings(options)
      # options_to_remove = map_options_to_remove(options)

      auto "Action" => "CreateEnvironment", "EnvironmentName" => name do
        option["ApplicationName"] = options[:application]
        option["CNAMEPrefix"] = options[:cname]
        option["Description"] = options[:description]
        array.hash["OptionSettings"] = settings
        # array.hash["OptionsToRemove"] = options_to_remove
        option["SolutionStackName"] = options[:stack]
        option["TemplateName"] = options[:template]
        option["VersionLabel"] = options[:version]
      end
    end
    bang :create_environment

    def create_storage_location(options = {})
    end
    bang :create_storage_location

    def delete_application(options = {})
    end
    bang :delete_application

    def delete_application_version(options = {})
    end
    bang :delete_application_version

    def delete_configuration_template(options = {})
    end
    bang :delete_configuration_template

    def delete_environment_configuration(options = {})
    end
    bang :delete_environment_configuration

    def describe_application_versions(app, options = {})
      auto "Action" => "DescribeApplicationVersions", "ApplicationName" => app do
        array["VersionLabels"] = options[:versions]
      end
    end
    bang :describe_application_versions

    def describe_applications(options = {})
      auto "Action" => "DescribeApplications" do
        array["ApplicationNames"] = options[:applications]
      end
    end
    bang :describe_applications

    def describe_configuration_options(options = {})
      auto "Action" => "DescribeConfigurationOptions" do |params|
        params.add_option("ApplicationName", options[:application])
        params.add_option("EnvironmentName", options[:environment])
        params.add_option("SolutionStackName", options[:solution_stack])
        params.add_option("TemplateName", options[:template])
        params.add_array_of_hashes("Options", options[:options], "Namespace" => :namespace, "OptionName" => :name)
      end
    end
    bang :describe_configuration_options

    def describe_configuration_settings(options = {})
    end
    bang :describe_configuration_settings

    def describe_environment_resources(options = {})
    end
    bang :describe_environment_resources

    def describe_environments(options = {})
      auto "Action" => "DescribeEnvironments" do
        option["ApplicationName"] = options[:application]
        array["EnvironmentIds"] = options[:environment_ids]
        array["EnvironmentNames"] = options[:environment_names]
        option["IncludeDeleted"] = options[:include_deleted]
        option["IncludedDeletedBackTo"] = options[:include_deleted_back_to]
        option["VersionLabel"] = options[:verison]
      end
    end
    bang :describe_environments

    def describe_events(options = {})
    end
    bang :describe_events

    def list_available_solution_stacks
      auto "Action" => "ListAvailableSolutionStacks"
    end
    bang :list_available_solution_stacks

    def rebuild_environment(options = {})
    end
    bang :rebuild_environment

    def request_environment_info(options = {})
    end
    bang :request_environment_info

    def restart_app_server(options = {})
    end
    bang :restart_app_server

    def retrieve_environment_info(options = {})
    end
    bang :retrieve_environment_info

    def swap_environment_cnam_es(options = {})
    end
    bang :swap_environment_cnam_es

    def terminate_environment(options = {})
    end
    bang :terminate_environment

    def update_application(options = {})
    end
    bang :update_application

    def update_application_version(options = {})
    end
    bang :update_application_version

    def update_configuration_template(options = {})
    end
    bang :update_configuration_template

    def update_environment(options = {})
    end
    bang :update_environment

    def validate_configuration_settings(options = {})
    end
    bang :validate_configuration_settings
  end
end
