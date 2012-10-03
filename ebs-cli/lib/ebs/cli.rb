require "aws/cli/base"
require "ebs"

module EBS
  module CLI
    class Main < AWS::CLI::Base
      namespace "ebs"

      type ConfigurationOptionSetting => "" do
      end
      type OptionSpecification => "" do
      end
      type S3Location => "" do
      end
      type SourceConfiguration => "" do
      end

      desc "check-dns-availability", "Checks if the specified CNAME is available."
      method_option :cname_prefix, desc: "The prefix used when this CNAME is reserved.", required: true, type: :string
      def check_dns_availability
        account.check_dns_availability!(options)
      end

      desc "create-application", "Creates an application that has one configuration template named default and no application versions."
      method_option :application_name, desc: "The name of the application.", required: true, type: :string
      method_option :description, desc: "Describes the application.", type: :string
      def create_application
        account.create_application!(options)
      end

      desc "create-application-version", "Creates an application version for the specified application."
      method_option :application_name, desc: "The name of the application. If no application is found with this name, and AutoCreateApplication is false, returns an InvalidParameterValue error.", required: true, type: :string
      method_option :auto_create_application, desc: "Determines how the system behaves if the specified application for this version does not already exist:", type: :boolean
      method_option :description, desc: "Describes this version.", type: :string
      method_option :source_bundle, desc: "The Amazon S3 bucket and key that identify the location of the source bundle for this version.", type: :s3_location
      method_option :version_label, desc: "A label identifying this version.", required: true, type: :string
      def create_application_version
        account.create_application_version!(options)
      end

      desc "create-configuration-template", "Creates a configuration template."
      method_option :application_name, desc: "The name of the application to associate with this configuration template. If no application is found with this name, AWS Elastic Beanstalk returns an InvalidParameterValue error.", required: true, type: :string
      method_option :description, desc: "Describes this configuration.", type: :string
      method_option :environment_id, desc: "The ID of the environment used with this configuration template.", type: :string
      method_option :option_settings, desc: "If specified, AWS Elastic Beanstalk sets the specified configuration option to the requested value. The new value overrides the value obtained from the solution stack or the source configuration template.", type: :array
      method_option :solution_stack_name, desc: "The name of the solution stack used by this configuration. The solution stack specifies the operating system, architecture, and application server for a configuration template. It determines the set of configuration options as well as the possible and default values.", type: :string
      method_option :source_configuration, desc: "If specified, AWS Elastic Beanstalk uses the configuration values from the specified configuration template to create a new configuration.", type: :source_configuration
      method_option :template_name, desc: "The name of the configuration template.", required: true, type: :string
      def create_configuration_template
        account.create_configuration_template!(options)
      end

      desc "create-environment", "Launches an environment for the specified application using the specified configuration."
      method_option :application_name, desc: "The name of the application that contains the version to be deployed.", required: true, type: :string
      method_option :cname_prefix, desc: "If specified, the environment attempts to use this value as the prefix for the CNAME. If not specified, the environment uses the environment name.", type: :string
      method_option :description, desc: "Describes this environment.", type: :string
      method_option :environment_name, desc: "A unique name for the deployment environment. Used in the application URL.", required: true, type: :string
      method_option :option_settings, desc: "If specified, AWS Elastic Beanstalk sets the specified configuration options to the requested value in the configuration set for the new environment. These override the values obtained from the solution stack or the configuration template.", type: :array
      method_option :options_to_remove, desc: "A list of custom user-defined configuration options to remove from the configuration set for this new environment.", type: :array
      method_option :solution_stack_name, desc: "This is an alternative to specifying a configuration name. If specified, AWS Elastic Beanstalk sets the configuration values to the default values associated with the specified solution stack.", type: :string
      method_option :template_name, desc: "The name of the configuration template to use in deployment. If no configuration template is found with this name, AWS Elastic Beanstalk returns an InvalidParameterValue error.", type: :string
      method_option :version_label, desc: "The name of the application version to deploy.", type: :string
      def create_environment
        account.create_environment!(options)
      end

      desc "create-storage-location", "Creates the Amazon S3 storage location for the account."
      def create_storage_location
        account.create_storage_location!
      end

      desc "delete-application", "Deletes the specified application along with all associated versions and configurations."
      method_option :application_name, desc: "The name of the application to delete.", required: true, type: :string
      def delete_application
        account.delete_application!(options)
      end

      desc "delete-application-version", "Deletes the specified version from the specified application."
      method_option :application_name, desc: "The name of the application to delete releases from.", required: true, type: :string
      method_option :delete_source_bundle, desc: "Indicates whether to delete the associated source bundle from Amazon S3:", type: :boolean
      method_option :version_label, desc: "The label of the version to delete.", required: true, type: :string
      def delete_application_version
        account.delete_application_version!(options)
      end

      desc "delete-configuration-template", "Deletes the specified configuration template."
      method_option :application_name, desc: "The name of the application to delete the configuration template from.", required: true, type: :string
      method_option :template_name, desc: "The name of the configuration template to delete.", required: true, type: :string
      def delete_configuration_template
        account.delete_configuration_template!(options)
      end

      desc "delete-environment-configuration", "Deletes the draft configuration associated with the running environment."
      method_option :application_name, desc: "The name of the application the environment is associated with.", required: true, type: :string
      method_option :environment_name, desc: "The name of the environment to delete the draft configuration from.", required: true, type: :string
      def delete_environment_configuration
        account.delete_environment_configuration!(options)
      end

      desc "describe-application-versions", "Returns descriptions for existing application versions."
      method_option :application_name, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to only include ones that are associated with the specified application.", type: :string
      method_option :version_labels, desc: "If specified, restricts the returned descriptions to only include ones that have the specified version labels.", type: :array
      table_method_options
      def describe_application_versions
        application_versions = account.describe_application_versions!(options)
        tableize_application_versions(application_versions).print
      end

      desc "describe-applications", "Returns the descriptions of existing applications."
      method_option :application_names, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to only include those with the specified names.", type: :array
      table_method_options
      def describe_applications
        applications = account.describe_applications!(options)
        tableize_applications(applications).print
      end

      desc "describe-configuration-options", "Describes the configuration options that are used in a particular configuration template or environment, or that a specified solution stack defines."
      method_option :application_name, desc: "The name of the application associated with the configuration template or environment. Only needed if you want to describe the configuration options associated with either the configuration template or environment.", type: :string
      method_option :environment_name, desc: "The name of the environment whose configuration options you want to describe.", type: :string
      method_option :options, desc: "If specified, restricts the descriptions to only the specified options.", type: :array
      method_option :solution_stack_name, desc: "The name of the solution stack whose configuration options you want to describe.", type: :string
      method_option :template_name, desc: "The name of the configuration template whose configuration options you want to describe.", type: :string
      table_method_options
      def describe_configuration_options
        configuration_options = account.describe_configuration_options!(options)
        tableize_configuration_options(configuration_options).print
      end

      desc "describe-configuration-settings", "Returns a description of the settings for the specified configuration set, that is, either a configuration template or the configuration set associated with a running environment."
      method_option :application_name, desc: "The application for the environment or configuration template.", required: true, type: :string
      method_option :environment_name, desc: "The name of the environment to describe.", type: :string
      method_option :template_name, desc: "The name of the configuration template to describe.", type: :string
      table_method_options
      def describe_configuration_settings
        configuration_settings = account.describe_configuration_settings!(options)
        tableize_configuration_settings(configuration_settings).print
      end

      desc "describe-environment-resources", "Returns AWS resources for this environment."
      method_option :environment_id, desc: "The ID of the environment to retrieve AWS resource usage data.", type: :string
      method_option :environment_name, desc: "The name of the environment to retrieve AWS resource usage data.", type: :string
      table_method_options
      def describe_environment_resources
        environment_resources = account.describe_environment_resources!(options)
        tableize_environment_resources(environment_resources).print
      end

      desc "describe-environments", "Returns descriptions for existing environments."
      method_option :application_name, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that are associated with this application.", type: :string
      method_option :environment_ids, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that have the specified IDs.", type: :array
      method_option :environment_names, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that have the specified names.", type: :array
      method_option :include_deleted, desc: "Indicates whether to include deleted environments:", type: :boolean
      method_option :included_deleted_back_to, desc: "If specified when IncludeDeleted is set to true, then environments deleted after this date are displayed.", type: :date_time
      method_option :version_label, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that are associated with this application version.", type: :string
      table_method_options
      def describe_environments
        environments = account.describe_environments!(options)
        tableize_environments(environments).print
      end

      desc "describe-events", "Returns list of event descriptions matching criteria up to the last 6 weeks."
      method_option :application_name, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those associated with this application.", type: :string
      method_option :end_time, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that occur up to, but not including, the EndTime.", type: :date_time
      method_option :environment_id, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this environment.", type: :string
      method_option :environment_name, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this environment.", type: :string
      method_option :max_records, desc: "Specifies the maximum number of events that can be returned, beginning with the most recent event.", type: :numeric
      method_option :request_id, desc: "If specified, AWS Elastic Beanstalk restricts the described events to include only those associated with this request ID.", type: :string
      method_option :severity, desc: "If specified, limits the events returned from this call to include only those with the specified severity or higher.", type: :string
      method_option :start_time, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that occur on or after this time.", type: :date_time
      method_option :template_name, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that are associated with this environment configuration.", type: :string
      method_option :version_label, desc: "If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this application version.", type: :string
      show_all_method_options :next_token
      table_method_options
      def describe_events
        events = show_all(:describe, :events, options)
        tableize_events(events).print
      end

      desc "list-available-solution-stacks", "Returns a list of the available solution stack names."
      def list_available_solution_stacks
        available_solution_stacks = account.list_available_solution_stacks!
        tableize_available_solution_stacks(available_solution_stacks).print
      end

      desc "rebuild-environment", "Deletes and recreates all of the AWS resources (for example: the Auto Scaling group, load balancer, etc."
      method_option :environment_id, desc: "The ID of the environment to rebuild.", type: :string
      method_option :environment_name, desc: "The name of the environment to rebuild.", type: :string
      def rebuild_environment
        account.rebuild_environment!(options)
      end

      desc "request-environment-info", "Initiates a request to compile the specified type of information of the deployed environment."
      method_option :environment_id, desc: "The ID of the environment of the requested data.", type: :string
      method_option :environment_name, desc: "The name of the environment of the requested data.", type: :string
      method_option :info_type, desc: "The type of information to request.", required: true, type: :string
      def request_environment_info
        account.request_environment_info!(options)
      end

      desc "restart-app-server", "Causes the environment to restart the application container server running on each Amazon EC2 instance."
      method_option :environment_id, desc: "The ID of the environment to restart the server for.", type: :string
      method_option :environment_name, desc: "The name of the environment to restart the server for.", type: :string
      def restart_app_server
        account.restart_app_server!(options)
      end

      desc "retrieve-environment-info", "Retrieves the compiled information from a RequestEnvironmentInfo request."
      method_option :environment_id, desc: "The ID of the data's environment.", type: :string
      method_option :environment_name, desc: "The name of the data's environment.", type: :string
      method_option :info_type, desc: "The type of information to retrieve.", required: true, type: :string
      def retrieve_environment_info
        account.retrieve_environment_info!(options)
      end

      desc "swap-environment-cnames", "Swaps the CNAMEs of two environments."
      method_option :destination_environment_id, desc: "The ID of the destination environment.", type: :string
      method_option :destination_environment_name, desc: "The name of the destination environment.", type: :string
      method_option :source_environment_id, desc: "The ID of the source environment.", type: :string
      method_option :source_environment_name, desc: "The name of the source environment.", type: :string
      def swap_environment_cnames
        account.swap_environment_cnames!(options)
      end

      desc "terminate-environment", "Terminates the specified environment."
      method_option :environment_id, desc: "The ID of the environment to terminate.", type: :string
      method_option :environment_name, desc: "The name of the environment to terminate.", type: :string
      method_option :terminate_resources, desc: "Indicates whether the associated AWS resources should shut down when the environment is terminated:", type: :boolean
      def terminate_environment
        account.terminate_environment!(options)
      end

      desc "update-application", "Updates the specified application to have the specified properties."
      method_option :application_name, desc: "The name of the application to update. If no such application is found, UpdateApplication returns an InvalidParameterValue error.", required: true, type: :string
      method_option :description, desc: "A new description for the application.", type: :string
      def update_application
        account.update_application!(options)
      end

      desc "update-application-version", "Updates the specified application version to have the specified properties."
      method_option :application_name, desc: "The name of the application associated with this version.", required: true, type: :string
      method_option :description, desc: "A new description for this release.", type: :string
      method_option :version_label, desc: "The name of the version to update.", required: true, type: :string
      def update_application_version
        account.update_application_version!(options)
      end

      desc "update-configuration-template", "Updates the specified configuration template to have the specified properties or configuration option values."
      method_option :application_name, desc: "The name of the application associated with the configuration template to update.", required: true, type: :string
      method_option :description, desc: "A new description for the configuration.", type: :string
      method_option :option_settings, desc: "A list of configuration option settings to update with the new specified option value.", type: :array
      method_option :options_to_remove, desc: "A list of configuration options to remove from the configuration set.", type: :array
      method_option :template_name, desc: "The name of the configuration template to update.", required: true, type: :string
      def update_configuration_template
        account.update_configuration_template!(options)
      end

      desc "update-environment", "Updates the environment description, deploys a new application version, updates the configuration settings to an entirely new configuration template, or updates select configuration option values in the running environment."
      method_option :description, desc: "If this parameter is specified, AWS Elastic Beanstalk updates the description of this environment.", type: :string
      method_option :environment_id, desc: "The ID of the environment to update.", type: :string
      method_option :environment_name, desc: "The name of the environment to update. If no environment with this name exists, AWS Elastic Beanstalk returns an InvalidParameterValue error.", type: :string
      method_option :option_settings, desc: "If specified, AWS Elastic Beanstalk updates the configuration set associated with the running environment and sets the specified configuration options to the requested value.", type: :array
      method_option :options_to_remove, desc: "A list of custom user-defined configuration options to remove from the configuration set for this environment.", type: :array
      method_option :template_name, desc: "If this parameter is specified, AWS Elastic Beanstalk deploys this configuration template to the environment. If no such configuration template is found, AWS Elastic Beanstalk returns an InvalidParameterValue error.", type: :string
      method_option :version_label, desc: "If this parameter is specified, AWS Elastic Beanstalk deploys the named application version to the environment. If no such application version is found, returns an InvalidParameterValue error.", type: :string
      def update_environment
        account.update_environment!(options)
      end

      desc "validate-configuration-settings", "Takes a set of configuration settings and either a configuration template or environment, and determines whether those values are valid."
      method_option :application_name, desc: "The name of the application that the configuration template or environment belongs to.", required: true, type: :string
      method_option :environment_name, desc: "The name of the environment to validate the settings against.", type: :string
      method_option :option_settings, desc: "A list of the options and desired values to evaluate.", required: true, type: :array
      method_option :template_name, desc: "The name of the configuration template to validate the settings against.", type: :string
      def validate_configuration_settings
        account.validate_configuration_settings!(options)
      end

      protected
        def account
          @account ||= EBS::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def tableize_application_versions(application_versions)
        end

        def tableize_applications(applications)
        end

        def tableize_configuration_options(configuration_options)
        end

        def tableize_configuration_settings(configuration_settings)
        end

        def tableize_environment_resources(environment_resources)
        end

        def tableize_environments(environments)
        end

        def tableize_events(events)
        end
    end
  end
end
