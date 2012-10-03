require "aws/type"

module EBS
  class Type < AWS::Type
  end

  class ApplicationDescription < Type
    field :ApplicationName
    array :ConfigurationTemplates
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    array :Versions
  end

  class S3Location < Type
    field :S3Bucket
    field :S3Key
  end

  class ApplicationVersionDescription < Type
    field :ApplicationName
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    field :SourceBundle, S3Location
    field :VersionLabel
  end

  class AutoScalingGroup < Type
    field :Name
  end

  class CheckDNSAvailabilityResult < Type
    field :Available, Boolean
    field :FullyQualifiedCNAME
  end

  class OptionRestrictionRegex < Type
    field :Label
    field :Pattern
  end

  class ConfigurationOptionDescription < Type
    field :ChangeSeverity
    field :DefaultValue
    field :MaxLength, Integer
    field :MaxValue, Integer
    field :MinValue, Integer
    field :Name
    field :Namespace
    field :Regex, OptionRestrictionRegex
    field :UserDefined, Boolean
    array :ValueOptions
    field :ValueType
  end

  class ConfigurationOptionSetting < Type
    field :Namespace
    field :OptionName
    field :Value
  end

  class ConfigurationSettingsDescription < Type
    field :ApplicationName
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :DeploymentStatus
    field :Description
    field :EnvironmentName
    array :OptionSettings, ConfigurationOptionSetting
    field :SolutionStackName
    field :TemplateName
  end

  class CreateApplicationResult < Type
    field :Application, ApplicationDescription
  end

  class CreateApplicationVersionResult < Type
    field :ApplicationVersion, ApplicationVersionDescription
  end

  class CreateConfigurationTemplateResult < Type
    field :ApplicationName
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :DeploymentStatus
    field :Description
    field :EnvironmentName
    array :OptionSettings, ConfigurationOptionSetting
    field :SolutionStackName
    field :TemplateName
  end

  class Listener < Type
    field :Port, Integer
    field :Protocol
  end

  class LoadBalancerDescription < Type
    field :Domain
    array :Listeners, Listener
    field :LoadBalancerName
  end

  class EnvironmentResourcesDescription < Type
    field :LoadBalancer, LoadBalancerDescription
  end

  class CreateEnvironmentResult < Type
    field :ApplicationName
    field :CNAME
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    field :EndpointURL
    field :EnvironmentId
    field :EnvironmentName
    field :Health
    field :Resources, EnvironmentResourcesDescription
    field :SolutionStackName
    field :Status
    field :TemplateName
    field :VersionLabel
  end

  class CreateStorageLocationResult < Type
    field :S3Bucket
  end

  class DescribeApplicationVersionsResult < Type
    array :ApplicationVersions, ApplicationVersionDescription
  end

  class DescribeApplicationsResult < Type
    array :Applications, ApplicationDescription
  end

  class DescribeConfigurationOptionsResult < Type
    array :Options, ConfigurationOptionDescription
    field :SolutionStackName
  end

  class DescribeConfigurationSettingsResult < Type
    array :ConfigurationSettings, ConfigurationSettingsDescription
  end

  class Instance < Type
    field :Id
  end

  class LaunchConfiguration < Type
    field :Name
  end

  class LoadBalancer < Type
    field :Name
  end

  class Trigger < Type
    field :Name
  end

  class EnvironmentResourceDescription < Type
    array :AutoScalingGroups, AutoScalingGroup
    field :EnvironmentName
    array :Instances, Instance
    array :LaunchConfigurations, LaunchConfiguration
    array :LoadBalancers, LoadBalancer
    array :Triggers, Trigger
  end

  class DescribeEnvironmentResourcesResult < Type
    field :EnvironmentResources, EnvironmentResourceDescription
  end

  class EnvironmentDescription < Type
    field :ApplicationName
    field :CNAME
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    field :EndpointURL
    field :EnvironmentId
    field :EnvironmentName
    field :Health
    field :Resources, EnvironmentResourcesDescription
    field :SolutionStackName
    field :Status
    field :TemplateName
    field :VersionLabel
  end

  class DescribeEnvironmentsResult < Type
    array :Environments, EnvironmentDescription
  end

  class EventDescription < Type
    field :ApplicationName
    field :EnvironmentName
    field :EventDate, DateTime
    field :Message
    field :RequestId
    field :Severity
    field :TemplateName
    field :VersionLabel
  end

  class DescribeEventsResult < Type
    array :Events, EventDescription
    field :NextToken
  end

  class EnvironmentInfoDescription < Type
    field :Ec2InstanceId
    field :InfoType
    field :Message
    field :SampleTimestamp, DateTime
  end

  class SolutionStackDescription < Type
    array :PermittedFileTypes
    field :SolutionStackName
  end

  class ListAvailableSolutionStacksResult < Type
    array :SolutionStackDetails, SolutionStackDescription
    array :SolutionStacks
  end

  class OptionSpecification < Type
    field :Namespace
    field :OptionName
  end

  class RetrieveEnvironmentInfoResult < Type
    array :EnvironmentInfo, EnvironmentInfoDescription
  end

  class SourceConfiguration < Type
    field :ApplicationName
    field :TemplateName
  end

  class TerminateEnvironmentResult < Type
    field :ApplicationName
    field :CNAME
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    field :EndpointURL
    field :EnvironmentId
    field :EnvironmentName
    field :Health
    field :Resources, EnvironmentResourcesDescription
    field :SolutionStackName
    field :Status
    field :TemplateName
    field :VersionLabel
  end

  class UpdateApplicationResult < Type
    field :Application, ApplicationDescription
  end

  class UpdateApplicationVersionResult < Type
    field :ApplicationVersion, ApplicationVersionDescription
  end

  class UpdateConfigurationTemplateResult < Type
    field :ApplicationName
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :DeploymentStatus
    field :Description
    field :EnvironmentName
    array :OptionSettings, ConfigurationOptionSetting
    field :SolutionStackName
    field :TemplateName
  end

  class UpdateEnvironmentResult < Type
    field :ApplicationName
    field :CNAME
    field :DateCreated, DateTime
    field :DateUpdated, DateTime
    field :Description
    field :EndpointURL
    field :EnvironmentId
    field :EnvironmentName
    field :Health
    field :Resources, EnvironmentResourcesDescription
    field :SolutionStackName
    field :Status
    field :TemplateName
    field :VersionLabel
  end

  class ValidationMessage < Type
    field :Message
    field :Namespace
    field :OptionName
    field :Severity
  end

  class ValidateConfigurationSettingsResult < Type
    array :Messages, ValidationMessage
  end
end
