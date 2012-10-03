require "aws/response"
require "aws/responses"

module EBS
  require "ebs/types"

  class Response < AWS::MetadataResponse
  end

  class CheckDNSAvailabilityResponse < Response
    field :CheckDNSAvailabilityResult, CheckDNSAvailabilityResult
  end

  class CreateApplicationResponse < Response
    field :CreateApplicationResult, CreateApplicationResult
  end

  class CreateApplicationVersionResponse < Response
    field :CreateApplicationVersionResult, CreateApplicationVersionResult
  end

  class CreateConfigurationTemplateResponse < Response
    field :CreateConfigurationTemplateResult, CreateConfigurationTemplateResult
  end

  class CreateEnvironmentResponse < Response
    field :CreateEnvironmentResult, CreateEnvironmentResult
  end

  class CreateStorageLocationResponse < Response
    field :CreateStorageLocationResult, CreateStorageLocationResult
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
    field :DescribeApplicationVersionsResult, DescribeApplicationVersionsResult
  end

  class DescribeApplicationsResponse < Response
    field :DescribeApplicationsResult, DescribeApplicationsResult
  end

  class DescribeConfigurationOptionsResponse < Response
    field :DescribeConfigurationOptionsResult, DescribeConfigurationOptionsResult
  end

  class DescribeConfigurationSettingsResponse < Response
    field :DescribeConfigurationSettingsResult, DescribeConfigurationSettingsResult
  end

  class DescribeEnvironmentResourcesResponse < Response
    field :DescribeEnvironmentResourcesResult, DescribeEnvironmentResourcesResult
  end

  class DescribeEnvironmentsResponse < Response
    field :DescribeEnvironmentsResult, DescribeEnvironmentsResult
  end

  class DescribeEventsResponse < Response
    field :DescribeEventsResult, DescribeEventsResult
  end

  class ListAvailableSolutionStacksResponse < Response
    field :ListAvailableSolutionStacksResult, ListAvailableSolutionStacksResult
  end

  class RebuildEnvironmentResponse < Response
  end

  class RequestEnvironmentInfoResponse < Response
  end

  class RestartAppServerResponse < Response
  end

  class RetrieveEnvironmentInfoResponse < Response
    field :RetrieveEnvironmentInfoResult, RetrieveEnvironmentInfoResult
  end

  class SwapEnvironmentCNAMEsResponse < Response
  end

  class TerminateEnvironmentResponse < Response
    field :TerminateEnvironmentResult, TerminateEnvironmentResult
  end

  class UpdateApplicationResponse < Response
    field :UpdateApplicationResult, UpdateApplicationResult
  end

  class UpdateApplicationVersionResponse < Response
    field :UpdateApplicationVersionResult, UpdateApplicationVersionResult
  end

  class UpdateConfigurationTemplateResponse < Response
    field :UpdateConfigurationTemplateResult, UpdateConfigurationTemplateResult
  end

  class UpdateEnvironmentResponse < Response
    field :UpdateEnvironmentResult, UpdateEnvironmentResult
  end

  class ValidateConfigurationSettingsResponse < Response
    field :ValidateConfigurationSettingsResult, ValidateConfigurationSettingsResult
  end
end
