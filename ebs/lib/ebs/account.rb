require "aws/account"

module EBS
  require "ebs/types"

  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = { endpoint: "https://elasticbeanstalk.%s.amazonaws.com", region: "us-east-1" }
    VERSION = "2010-12-01"

    auto add: ConfigurationOptionSetting
    auto add: OptionSpecification
    auto add: S3Location
    auto add: SourceConfiguration

    # Checks if the specified CNAME is available.
    # @param [Hash] options Options for the API call
    # @option options [String] :cname_prefix *Required* -- _CNAMEPrefix_ -- The prefix used when this CNAME is reserved.
    # @return [CheckDNSAvailabilityResponse, AWS::ErrorResponse]
    def check_dns_availability(options = {})
      auto "Action" => "CheckDNSAvailability" do
        self.options = options
        string.required["CNAMEPrefix"] = :cname_prefix
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [CheckDNSAvailabilityResponse]
    bang :check_dns_availability

    # Creates an application that has one configuration template named default and no application versions.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application.
    # @option options [String] :description _Description_ -- Describes the application.
    # @return [CreateApplicationResponse, AWS::ErrorResponse]
    def create_application(options = {})
      auto "Action" => "CreateApplication" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["Description"] = :description
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, TooManyApplicationsError]
    # @return [CreateApplicationResponse]
    bang :create_application

    # Creates an application version for the specified application.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application. If no application is found with this name, and AutoCreateApplication is false, returns an InvalidParameterValue error.
    # @option options [true, false] :auto_create_application (false) _AutoCreateApplication_ -- Determines how the system behaves if the specified application for this version does not already exist:
    # @option options [String] :description _Description_ -- Describes this version.
    # @option options [S3Location] :source_bundle (If not specified, AWS Elastic Beanstalk uses a sample application. If only partially specified (for example, a bucket is provided but not the key) or if no data is found at the Amazon S3 location, AWS Elastic Beanstalk returns an InvalidParameterCombination error.) _SourceBundle_ -- The Amazon S3 bucket and key that identify the location of the source bundle for this version.
    # @option options [String] :version_label *Required* -- _VersionLabel_ -- A label identifying this version.
    # @return [CreateApplicationVersionResponse, AWS::ErrorResponse]
    def create_application_version(options = {})
      auto "Action" => "CreateApplicationVersion" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        boolean["AutoCreateApplication"] = :auto_create_application
        string["Description"] = :description
        s3_location["SourceBundle"] = :source_bundle
        string.required["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, TooManyApplicationVersionsError, TooManyApplicationsError]
    # @return [CreateApplicationVersionResponse]
    bang :create_application_version

    # Creates a configuration template. Templates are associated with a specific application and are used to deploy different versions of the application with the same configuration settings.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application to associate with this configuration template. If no application is found with this name, AWS Elastic Beanstalk returns an InvalidParameterValue error.
    # @option options [String] :description _Description_ -- Describes this configuration.
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment used with this configuration template.
    # @option options [ConfigurationOptionSetting] :option_settings _OptionSettings_ -- If specified, AWS Elastic Beanstalk sets the specified configuration option to the requested value. The new value overrides the value obtained from the solution stack or the source configuration template.
    # @option options [String] :solution_stack_name (If the SolutionStackName is not specified and the source configuration parameter is blank, AWS Elastic Beanstalk uses the default solution stack.) _SolutionStackName_ -- The name of the solution stack used by this configuration. The solution stack specifies the operating system, architecture, and application server for a configuration template. It determines the set of configuration options as well as the possible and default values.
    # @option options [SourceConfiguration] :source_configuration _SourceConfiguration_ -- If specified, AWS Elastic Beanstalk uses the configuration values from the specified configuration template to create a new configuration.
    # @option options [String] :template_name (If a configuration template already exists with this name, AWS Elastic Beanstalk returns an InvalidParameterValue error.) *Required* -- _TemplateName_ -- The name of the configuration template.
    # @return [CreateConfigurationTemplateResponse, AWS::ErrorResponse]
    def create_configuration_template(options = {})
      auto "Action" => "CreateConfigurationTemplate" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["Description"] = :description
        string["EnvironmentId"] = :environment_id
        configuration_option_setting.array["OptionSettings"] = :option_settings
        string["SolutionStackName"] = :solution_stack_name
        source_configuration["SourceConfiguration"] = :source_configuration
        string.required["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, TooManyConfigurationTemplatesError]
    # @return [CreateConfigurationTemplateResponse]
    bang :create_configuration_template

    # Launches an environment for the specified application using the specified configuration.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application that contains the version to be deployed.
    # @option options [String] :cname_prefix _CNAMEPrefix_ -- If specified, the environment attempts to use this value as the prefix for the CNAME. If not specified, the environment uses the environment name.
    # @option options [String] :description _Description_ -- Describes this environment.
    # @option options [String] :environment_name (If the CNAME parameter is not specified, the environment name becomes part of the CNAME, and therefore part of the visible URL for your application.) *Required* -- _EnvironmentName_ -- A unique name for the deployment environment. Used in the application URL.
    # @option options [ConfigurationOptionSetting] :option_settings _OptionSettings_ -- If specified, AWS Elastic Beanstalk sets the specified configuration options to the requested value in the configuration set for the new environment. These override the values obtained from the solution stack or the configuration template.
    # @option options [OptionSpecification] :options_to_remove _OptionsToRemove_ -- A list of custom user-defined configuration options to remove from the configuration set for this new environment.
    # @option options [String] :solution_stack_name _SolutionStackName_ -- This is an alternative to specifying a configuration name. If specified, AWS Elastic Beanstalk sets the configuration values to the default values associated with the specified solution stack.
    # @option options [String] :template_name _TemplateName_ -- The name of the configuration template to use in deployment. If no configuration template is found with this name, AWS Elastic Beanstalk returns an InvalidParameterValue error.
    # @option options [String] :version_label (If not specified, AWS Elastic Beanstalk attempts to launch the most recently created application version.) _VersionLabel_ -- The name of the application version to deploy.
    # @return [CreateEnvironmentResponse, AWS::ErrorResponse]
    def create_environment(options = {})
      auto "Action" => "CreateEnvironment" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["CNAMEPrefix"] = :cname_prefix
        string["Description"] = :description
        string.required["EnvironmentName"] = :environment_name
        configuration_option_setting.array["OptionSettings"] = :option_settings
        option_specification.array["OptionsToRemove"] = :options_to_remove
        string["SolutionStackName"] = :solution_stack_name
        string["TemplateName"] = :template_name
        string["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, TooManyEnvironmentsError]
    # @return [CreateEnvironmentResponse]
    bang :create_environment

    # Creates the Amazon S3 storage location for the account.
    # @return [CreateStorageLocationResponse, AWS::ErrorResponse]
    def create_storage_location
      auto "Action" => "CreateStorageLocation"
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, S3SubscriptionRequiredError, TooManyBucketsError]
    # @return [CreateStorageLocationResponse]
    bang :create_storage_location

    # Deletes the specified application along with all associated versions and configurations.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application to delete.
    # @return [DeleteApplicationResponse, AWS::ErrorResponse]
    def delete_application(options = {})
      auto "Action" => "DeleteApplication" do
        self.options = options
        string.required["ApplicationName"] = :application_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DeleteApplicationResponse]
    bang :delete_application

    # Deletes the specified version from the specified application.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application to delete releases from.
    # @option options [true, false] :delete_source_bundle _DeleteSourceBundle_ -- Indicates whether to delete the associated source bundle from Amazon S3:
    # @option options [String] :version_label *Required* -- _VersionLabel_ -- The label of the version to delete.
    # @return [DeleteApplicationVersionResponse, AWS::ErrorResponse]
    def delete_application_version(options = {})
      auto "Action" => "DeleteApplicationVersion" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        boolean["DeleteSourceBundle"] = :delete_source_bundle
        string.required["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError, SourceBundleDeletionError]
    # @return [DeleteApplicationVersionResponse]
    bang :delete_application_version

    # Deletes the specified configuration template.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application to delete the configuration template from.
    # @option options [String] :template_name *Required* -- _TemplateName_ -- The name of the configuration template to delete.
    # @return [DeleteConfigurationTemplateResponse, AWS::ErrorResponse]
    def delete_configuration_template(options = {})
      auto "Action" => "DeleteConfigurationTemplate" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string.required["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DeleteConfigurationTemplateResponse]
    bang :delete_configuration_template

    # Deletes the draft configuration associated with the running environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application the environment is associated with.
    # @option options [String] :environment_name *Required* -- _EnvironmentName_ -- The name of the environment to delete the draft configuration from.
    # @return [DeleteEnvironmentConfigurationResponse, AWS::ErrorResponse]
    def delete_environment_configuration(options = {})
      auto "Action" => "DeleteEnvironmentConfiguration" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string.required["EnvironmentName"] = :environment_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DeleteEnvironmentConfigurationResponse]
    bang :delete_environment_configuration

    # Returns descriptions for existing application versions.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name _ApplicationName_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to only include ones that are associated with the specified application.
    # @option options [String] :version_labels _VersionLabels_ -- If specified, restricts the returned descriptions to only include ones that have the specified version labels.
    # @return [DescribeApplicationVersionsResponse, AWS::ErrorResponse]
    def describe_application_versions(options = {})
      auto "Action" => "DescribeApplicationVersions" do
        self.options = options
        string["ApplicationName"] = :application_name
        string.array["VersionLabels"] = :version_labels
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeApplicationVersionsResponse]
    bang :describe_application_versions

    # Returns the descriptions of existing applications.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_names _ApplicationNames_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to only include those with the specified names.
    # @return [DescribeApplicationsResponse, AWS::ErrorResponse]
    def describe_applications(options = {})
      auto "Action" => "DescribeApplications" do
        self.options = options
        string.array["ApplicationNames"] = :application_names
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeApplicationsResponse]
    bang :describe_applications

    # Describes the configuration options that are used in a particular configuration template or environment, or that a specified solution stack defines. The description includes the values the options, their default values, and an indication of the required action on a running environment if an option value is changed.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name _ApplicationName_ -- The name of the application associated with the configuration template or environment. Only needed if you want to describe the configuration options associated with either the configuration template or environment.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment whose configuration options you want to describe.
    # @option options [OptionSpecification] :options _Options_ -- If specified, restricts the descriptions to only the specified options.
    # @option options [String] :solution_stack_name _SolutionStackName_ -- The name of the solution stack whose configuration options you want to describe.
    # @option options [String] :template_name _TemplateName_ -- The name of the configuration template whose configuration options you want to describe.
    # @return [DescribeConfigurationOptionsResponse, AWS::ErrorResponse]
    def describe_configuration_options(options = {})
      auto "Action" => "DescribeConfigurationOptions" do
        self.options = options
        string["ApplicationName"] = :application_name
        string["EnvironmentName"] = :environment_name
        option_specification.array["Options"] = :options
        string["SolutionStackName"] = :solution_stack_name
        string["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeConfigurationOptionsResponse]
    bang :describe_configuration_options

    # Returns a description of the settings for the specified configuration set, that is, either a configuration template or the configuration set associated with a running environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The application for the environment or configuration template.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to describe.
    # @option options [String] :template_name _TemplateName_ -- The name of the configuration template to describe.
    # @return [DescribeConfigurationSettingsResponse, AWS::ErrorResponse]
    def describe_configuration_settings(options = {})
      auto "Action" => "DescribeConfigurationSettings" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["EnvironmentName"] = :environment_name
        string["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeConfigurationSettingsResponse]
    bang :describe_configuration_settings

    # Returns AWS resources for this environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment to retrieve AWS resource usage data.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to retrieve AWS resource usage data.
    # @return [DescribeEnvironmentResourcesResponse, AWS::ErrorResponse]
    def describe_environment_resources(options = {})
      auto "Action" => "DescribeEnvironmentResources" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeEnvironmentResourcesResponse]
    bang :describe_environment_resources

    # Returns descriptions for existing environments.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name _ApplicationName_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that are associated with this application.
    # @option options [String] :environment_ids _EnvironmentIds_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that have the specified IDs.
    # @option options [String] :environment_names _EnvironmentNames_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that have the specified names.
    # @option options [true, false] :include_deleted _IncludeDeleted_ -- Indicates whether to include deleted environments:
    # @option options [DateTime] :included_deleted_back_to _IncludedDeletedBackTo_ -- If specified when IncludeDeleted is set to true, then environments deleted after this date are displayed.
    # @option options [String] :version_label _VersionLabel_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those that are associated with this application version.
    # @return [DescribeEnvironmentsResponse, AWS::ErrorResponse]
    def describe_environments(options = {})
      auto "Action" => "DescribeEnvironments" do
        self.options = options
        string["ApplicationName"] = :application_name
        string.array["EnvironmentIds"] = :environment_ids
        string.array["EnvironmentNames"] = :environment_names
        boolean["IncludeDeleted"] = :include_deleted
        date_time["IncludedDeletedBackTo"] = :included_deleted_back_to
        string["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeEnvironmentsResponse]
    bang :describe_environments

    # Returns list of event descriptions matching criteria up to the last 6 weeks.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name _ApplicationName_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to include only those associated with this application.
    # @option options [DateTime] :end_time _EndTime_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that occur up to, but not including, the EndTime.
    # @option options [String] :environment_id _EnvironmentId_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this environment.
    # @option options [String] :environment_name _EnvironmentName_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this environment.
    # @option options [Integer] :max_records _MaxRecords_ -- Specifies the maximum number of events that can be returned, beginning with the most recent event.
    # @option options [String] :next_token _NextToken_ -- Pagination token. If specified, the events return the next batch of results.
    # @option options [String] :request_id _RequestId_ -- If specified, AWS Elastic Beanstalk restricts the described events to include only those associated with this request ID.
    # @option options [String] :severity _Severity_ -- If specified, limits the events returned from this call to include only those with the specified severity or higher.
    # @option options [DateTime] :start_time _StartTime_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that occur on or after this time.
    # @option options [String] :template_name _TemplateName_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those that are associated with this environment configuration.
    # @option options [String] :version_label _VersionLabel_ -- If specified, AWS Elastic Beanstalk restricts the returned descriptions to those associated with this application version.
    # @return [DescribeEventsResponse, AWS::ErrorResponse]
    def describe_events(options = {})
      auto "Action" => "DescribeEvents" do
        self.options = options
        string["ApplicationName"] = :application_name
        date_time["EndTime"] = :end_time
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
        integer["MaxRecords"] = :max_records
        string["NextToken"] = :next_token
        string["RequestId"] = :request_id
        string["Severity"] = :severity
        date_time["StartTime"] = :start_time
        string["TemplateName"] = :template_name
        string["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [DescribeEventsResponse]
    bang :describe_events

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [Array<EventDescription>]
    all :describe, :events, :next_token

    # Returns a list of the available solution stack names.
    # @return [ListAvailableSolutionStacksResponse, AWS::ErrorResponse]
    def list_available_solution_stacks
      auto "Action" => "ListAvailableSolutionStacks"
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [ListAvailableSolutionStacksResponse]
    bang :list_available_solution_stacks

    # Deletes and recreates all of the AWS resources (for example: the Auto Scaling group, load balancer, etc.) for a specified environment and forces a restart.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment to rebuild.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to rebuild.
    # @return [RebuildEnvironmentResponse, AWS::ErrorResponse]
    def rebuild_environment(options = {})
      auto "Action" => "RebuildEnvironment" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [RebuildEnvironmentResponse]
    bang :rebuild_environment

    # Initiates a request to compile the specified type of information of the deployed environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment of the requested data.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment of the requested data.
    # @option options [String] :info_type *Required* -- _InfoType_ -- The type of information to request.
    # @return [RequestEnvironmentInfoResponse, AWS::ErrorResponse]
    def request_environment_info(options = {})
      auto "Action" => "RequestEnvironmentInfo" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
        string.required["InfoType"] = :info_type
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [RequestEnvironmentInfoResponse]
    bang :request_environment_info

    # Causes the environment to restart the application container server running on each Amazon EC2 instance.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment to restart the server for.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to restart the server for.
    # @return [RestartAppServerResponse, AWS::ErrorResponse]
    def restart_app_server(options = {})
      auto "Action" => "RestartAppServer" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [RestartAppServerResponse]
    bang :restart_app_server

    # Retrieves the compiled information from a RequestEnvironmentInfo request.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the data's environment.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the data's environment.
    # @option options [String] :info_type *Required* -- _InfoType_ -- The type of information to retrieve.
    # @return [RetrieveEnvironmentInfoResponse, AWS::ErrorResponse]
    def retrieve_environment_info(options = {})
      auto "Action" => "RetrieveEnvironmentInfo" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
        string.required["InfoType"] = :info_type
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [RetrieveEnvironmentInfoResponse]
    bang :retrieve_environment_info

    # Swaps the CNAMEs of two environments.
    # @param [Hash] options Options for the API call
    # @option options [String] :destination_environment_id _DestinationEnvironmentId_ -- The ID of the destination environment.
    # @option options [String] :destination_environment_name _DestinationEnvironmentName_ -- The name of the destination environment.
    # @option options [String] :source_environment_id _SourceEnvironmentId_ -- The ID of the source environment.
    # @option options [String] :source_environment_name _SourceEnvironmentName_ -- The name of the source environment.
    # @return [SwapEnvironmentCNAMEsResponse, AWS::ErrorResponse]
    def swap_environment_cnames(options = {})
      auto "Action" => "SwapEnvironmentCNAMEs" do
        self.options = options
        string["DestinationEnvironmentId"] = :destination_environment_id
        string["DestinationEnvironmentName"] = :destination_environment_name
        string["SourceEnvironmentId"] = :source_environment_id
        string["SourceEnvironmentName"] = :source_environment_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [SwapEnvironmentCNAMEsResponse]
    bang :swap_environment_cnames

    # Terminates the specified environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment to terminate.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to terminate.
    # @option options [true, false] :terminate_resources (true) _TerminateResources_ -- Indicates whether the associated AWS resources should shut down when the environment is terminated:
    # @return [TerminateEnvironmentResponse, AWS::ErrorResponse]
    def terminate_environment(options = {})
      auto "Action" => "TerminateEnvironment" do
        self.options = options
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
        boolean["TerminateResources"] = :terminate_resources
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [TerminateEnvironmentResponse]
    bang :terminate_environment

    # Updates the specified application to have the specified properties.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application to update. If no such application is found, UpdateApplication returns an InvalidParameterValue error.
    # @option options [String] :description (If not specified, AWS Elastic Beanstalk does not update the description.) _Description_ -- A new description for the application.
    # @return [UpdateApplicationResponse, AWS::ErrorResponse]
    def update_application(options = {})
      auto "Action" => "UpdateApplication" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["Description"] = :description
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [UpdateApplicationResponse]
    bang :update_application

    # Updates the specified application version to have the specified properties.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application associated with this version.
    # @option options [String] :description _Description_ -- A new description for this release.
    # @option options [String] :version_label *Required* -- _VersionLabel_ -- The name of the version to update.
    # @return [UpdateApplicationVersionResponse, AWS::ErrorResponse]
    def update_application_version(options = {})
      auto "Action" => "UpdateApplicationVersion" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["Description"] = :description
        string.required["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [UpdateApplicationVersionResponse]
    bang :update_application_version

    # Updates the specified configuration template to have the specified properties or configuration option values.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application associated with the configuration template to update.
    # @option options [String] :description _Description_ -- A new description for the configuration.
    # @option options [ConfigurationOptionSetting] :option_settings _OptionSettings_ -- A list of configuration option settings to update with the new specified option value.
    # @option options [OptionSpecification] :options_to_remove _OptionsToRemove_ -- A list of configuration options to remove from the configuration set.
    # @option options [String] :template_name *Required* -- _TemplateName_ -- The name of the configuration template to update.
    # @return [UpdateConfigurationTemplateResponse, AWS::ErrorResponse]
    def update_configuration_template(options = {})
      auto "Action" => "UpdateConfigurationTemplate" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["Description"] = :description
        configuration_option_setting.array["OptionSettings"] = :option_settings
        option_specification.array["OptionsToRemove"] = :options_to_remove
        string.required["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [UpdateConfigurationTemplateResponse]
    bang :update_configuration_template

    # Updates the environment description, deploys a new application version, updates the configuration settings to an entirely new configuration template, or updates select configuration option values in the running environment.
    # @param [Hash] options Options for the API call
    # @option options [String] :description _Description_ -- If this parameter is specified, AWS Elastic Beanstalk updates the description of this environment.
    # @option options [String] :environment_id _EnvironmentId_ -- The ID of the environment to update.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to update. If no environment with this name exists, AWS Elastic Beanstalk returns an InvalidParameterValue error.
    # @option options [ConfigurationOptionSetting] :option_settings _OptionSettings_ -- If specified, AWS Elastic Beanstalk updates the configuration set associated with the running environment and sets the specified configuration options to the requested value.
    # @option options [OptionSpecification] :options_to_remove _OptionsToRemove_ -- A list of custom user-defined configuration options to remove from the configuration set for this environment.
    # @option options [String] :template_name _TemplateName_ -- If this parameter is specified, AWS Elastic Beanstalk deploys this configuration template to the environment. If no such configuration template is found, AWS Elastic Beanstalk returns an InvalidParameterValue error.
    # @option options [String] :version_label _VersionLabel_ -- If this parameter is specified, AWS Elastic Beanstalk deploys the named application version to the environment. If no such application version is found, returns an InvalidParameterValue error.
    # @return [UpdateEnvironmentResponse, AWS::ErrorResponse]
    def update_environment(options = {})
      auto "Action" => "UpdateEnvironment" do
        self.options = options
        string["Description"] = :description
        string["EnvironmentId"] = :environment_id
        string["EnvironmentName"] = :environment_name
        configuration_option_setting.array["OptionSettings"] = :option_settings
        option_specification.array["OptionsToRemove"] = :options_to_remove
        string["TemplateName"] = :template_name
        string["VersionLabel"] = :version_label
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [UpdateEnvironmentResponse]
    bang :update_environment

    # Takes a set of configuration settings and either a configuration template or environment, and determines whether those values are valid.
    # @param [Hash] options Options for the API call
    # @option options [String] :application_name *Required* -- _ApplicationName_ -- The name of the application that the configuration template or environment belongs to.
    # @option options [String] :environment_name _EnvironmentName_ -- The name of the environment to validate the settings against.
    # @option options [ConfigurationOptionSetting] :option_settings *Required* -- _OptionSettings_ -- A list of the options and desired values to evaluate.
    # @option options [String] :template_name _TemplateName_ -- The name of the configuration template to validate the settings against.
    # @return [ValidateConfigurationSettingsResponse, AWS::ErrorResponse]
    def validate_configuration_settings(options = {})
      auto "Action" => "ValidateConfigurationSettings" do
        self.options = options
        string.required["ApplicationName"] = :application_name
        string["EnvironmentName"] = :environment_name
        configuration_option_setting.array.required["OptionSettings"] = :option_settings
        string["TemplateName"] = :template_name
      end
    end

    # @raise [AWS::IncompleteSignatureError, AWS::InternalFailureError, AWS::InvalidActionError, AWS::InvalidClientTokenIdError, AWS::InvalidParameterCombinationError, AWS::InvalidParameterValueError, AWS::InvalidQueryParameterError, AWS::MalformedQueryStringError, AWS::MissingActionError, AWS::MissingAuthenticationTokenError, AWS::MissingParameterError, AWS::OptInRequiredError, AWS::RequestExpiredError, AWS::ServiceUnavailableError, AWS::ThrottlingError]
    # @return [ValidateConfigurationSettingsResponse]
    bang :validate_configuration_settings
  end
end
