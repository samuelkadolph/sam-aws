require "aws/response"

module EBS
  class CheckDNSAvailabilityResponse < AWS::MetadataResponse
    struct "CheckDNSAvailabilityResult" do
      field "Available"
      field "FullyQualifiedCNAME"
    end
  end

  class CreateApplicationResponse < AWS::MetadataResponse
    struct "CreateApplicationResult" do
      struct "Application" do
        field "ApplicationName"
        field "ConfigurationTemplates"
        field "DateCreated"
        field "DateUpdated"
        field "Description"
        field "Versions"
      end
    end
  end

  class CreateApplicationVersionResponse < AWS::MetadataResponse
    struct "CreateApplicationVersionResult" do
      struct "ApplicationVersion" do
        field "ApplicationName"
        field "DateCreated"
        field "DateUpdated"
        field "Description"
        struct "SourceBundle" do
          field "S3Bucket"
          field "S3Key"
        end
        field "VersionLabel"
      end
    end
  end

  class CreateConfigurationTemplateResponse < AWS::MetadataResponse
    struct "CreateConfigurationTemplateResult" do
      field "ApplicationName"
      field "DateCreated"
      field "DateUpdated"
      field "DeploymentStatus"
      field "Description"
      field "EnvironmentName"
      array "OptionSettings" do
        field "Namespace"
        field "OptionName"
        field "Value"
      end
      field "SolutionStackName"
      field "TemplateName"
    end
  end

  class CreateEnvironmentResponse < AWS::MetadataResponse
    struct "CreateEnvironmentResult" do
      field "ApplicationName"
      field "CNAME"
      field "DateCreated"
      field "DateUpdated"
      field "Description"
      field "EndpointURL"
      field "EnvironmentId"
      field "EnvironmentName"
      field "Health"
      struct "Resources" do
        field "LoadBalancer"
      end
      field "SolutionStackName"
      field "Status"
      field "TemplateName"
      field "VersionLabel"
    end
  end

  class CreateStorageLocationResponse < AWS::MetadataResponse
    struct "CreateStorageLocationResult" do
      field "S3Bucket"
    end
  end

  class DeleteApplicationResponse < AWS::MetadataResponse
  end

  class DeleteApplicationVersionResponse < AWS::MetadataResponse
  end

  class DeleteConfigurationTemplateResponse < AWS::MetadataResponse
  end

  class DeleteEnvironmentConfigurationResponse < AWS::MetadataResponse
  end

  class DescribeApplicationVersionsResponse < AWS::MetadataResponse
    struct "DescribeApplicationVersionsResult" do
      array "ApplicationVersions" do
        field "ApplicationName"
        field "DateCreated"
        field "DateUpdated"
        field "Description"
        struct "SourceBundle" do
          field "S3Bucket"
          field "S3Key"
        end
        field "VersionLabel"
      end
    end
  end

  class DescribeApplicationsResponse < AWS::MetadataResponse
    struct "DescribeApplicationsResult" do
      array "Applications" do
        field "ApplicationName"
        field "ConfigurationTemplates"
        field "DateCreated"
        field "DateUpdated"
        field "Description"
        array "Versions"
      end
    end
  end

  class DescribeConfigurationOptionsResponse < AWS::MetadataResponse
    struct "DescribeConfigurationOptionsResult" do
    end
  end

  class DescribeConfigurationSettingsResponse < AWS::MetadataResponse
    struct "DescribeConfigurationSettingsResult" do
    end
  end

  class DescribeEnvironmentResourcesResponse < AWS::MetadataResponse
    struct "DescribeEnvironmentResourcesResult" do
    end
  end

  class DescribeEnvironmentsResponse < AWS::MetadataResponse
    struct "DescribeEnvironmentsResult" do
    end
  end

  class DescribeEventsResponse < AWS::MetadataResponse
    struct "DescribeEventsResult" do
    end
  end

  class ListAvailableSolutionStacksResponse < AWS::MetadataResponse
    struct "ListAvailableSolutionStacksResult" do
    end
  end

  class RebuildEnvironmentResponse < AWS::MetadataResponse
    struct "RebuildEnvironmentResult" do
    end
  end

  class RequestEnvironmentInfoResponse < AWS::MetadataResponse
    struct "RequestEnvironmentInfoResult" do
    end
  end

  class RestartAppServerResponse < AWS::MetadataResponse
    struct "RestartAppServerResult" do
    end
  end

  class RetrieveEnvironmentInfoResponse < AWS::MetadataResponse
    struct "RetrieveEnvironmentInfoResult" do
    end
  end

  class SwapEnvironmentCNAMEsResponse < AWS::MetadataResponse
    struct "SwapEnvironmentCNAMEsResult" do
    end
  end

  class TerminateEnvironmentResponse < AWS::MetadataResponse
    struct "TerminateEnvironmentResult" do
    end
  end

  class UpdateApplicationResponse < AWS::MetadataResponse
    struct "UpdateApplicationResult" do
    end
  end

  class UpdateApplicationVersionResponse < AWS::MetadataResponse
    struct "UpdateApplicationVersionResult" do
    end
  end

  class UpdateConfigurationTemplateResponse < AWS::MetadataResponse
    struct "UpdateConfigurationTemplateResult" do
    end
  end

  class UpdateEnvironmentResponse < AWS::MetadataResponse
    struct "UpdateEnvironmentResult" do
    end
  end

  class ValidateConfigurationSettingsResponse < AWS::MetadataResponse
    struct "ValidateConfigurationSettingsResult" do
    end
  end
end
