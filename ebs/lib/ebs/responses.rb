module EBS
  class CheckDNSAvailabilityResponse < Response
    struct :check_dns_availability_result do
      check_dns_availability_result
    end
  end

  class CreateApplicationResponse < Response
    struct :create_application_result do
      create_application_result
    end
  end

  class CreateApplicationVersionResponse < Response
    struct :create_application_version_result do
      create_application_version_result
    end
  end

  class CreateConfigurationTemplateResponse < Response
    struct :create_configuration_template_result do
      configuration_settings_description
    end
  end

  class CreateEnvironmentResponse < Response
    struct :create_environment_result do
      create_environment_result
    end
  end

  class CreateStorageLocationResponse < Response
    struct :create_storage_location_result do
      create_storage_location_result
    end
  end

  class DeleteApplicationResponse < Response
  end

  class DeleteApplicationVersionResponse < Response
  end

  class DeleteConfigurationTemplateResponse < Response
  end

  class DeleteEnvironmentConfigurationResponse < Response
  end

  class DescribeApplicationVersionsResponse < Response
    struct :describe_application_versions_result do
      describe_application_versions_result
    end
  end

  class DescribeApplicationsResponse < Response
    struct :describe_applications_result do
      describe_applications_result
    end
  end

  class DescribeConfigurationOptionsResponse < Response
    struct :describe_configuration_options_result do
      describe_configuration_options_result
    end
  end

  class DescribeConfigurationSettingsResponse < Response
    struct :describe_configuration_settings_result do
      describe_configuration_settings_result
    end
  end

  class DescribeEnvironmentResourcesResponse < Response
    struct :describe_environment_resources_result do
      describe_environment_resources_result
    end
  end

  class DescribeEnvironmentsResponse < Response
    struct :describe_environments_result do
      describe_environments_result
    end
  end

  class DescribeEventsResponse < Response
    struct :describe_events_result do
      describe_events_result
    end
  end

  class ListAvailableSolutionStacksResponse < Response
    struct :list_available_solution_stacks_result do
      list_available_solution_stacks_result
    end
  end

  class RebuildEnvironmentResponse < Response
  end

  class RequestEnvironmentInfoResponse < Response
  end

  class RestartAppServerResponse < Response
  end

  class RetrieveEnvironmentInfoResponse < Response
    struct :retrieve_environment_info_result do
      retrieve_environment_info_result
    end
  end

  class SwapEnvironmentCNAMEsResponse < Response
  end

  class TerminateEnvironmentResponse < Response
    struct :terminate_environment_result do
      terminate_environment_result
    end
  end

  class UpdateApplicationResponse < Response
    struct :update_application_result do
      update_application_result
    end
  end

  class UpdateApplicationVersionResponse < Response
    struct :update_application_version_result do
      update_application_version_result
    end
  end

  class UpdateConfigurationTemplateResponse < Response
    struct :update_configuration_template_result do
      update_configuration_template_result
    end
  end

  class UpdateEnvironmentResponse < Response
    struct :update_environment_result do
      update_environment_result
    end
  end

  class ValidateConfigurationSettingsResponse < Response
    struct :validate_configuration_settings_result do
      validate_configuration_settings_result
    end
  end
end
