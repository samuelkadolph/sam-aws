require "aws/response"

module ELB
  class ConfigureHealthCheckResponse < AWS::MetadataResponse
    struct "ConfigureHealthCheckResult" do
      struct "HealthCheck" do
        field "HealthyThreshold", Fixnum
        field "Interval", Fixnum
        field "Target"
        field "Timeout", Fixnum
        field "UnhealthyThreshold", Fixnum
      end
    end
  end

  class CreateAppCookieStickinessPolicyResponse < AWS::MetadataResponse
  end

  class CreateLBCookieStickinessPolicyResponse < AWS::MetadataResponse
    struct "CreateLoadBalancerPolicyResult" do
    end
  end

  class CreateLoadBalancerResponse < AWS::MetadataResponse
    struct "CreateLoadBalancerResult" do
      field "DNSName"
    end
  end

  class CreateLoadBalancerListenersResponse < AWS::MetadataResponse
  end

  class CreateLoadBalancerPolicyResponse < AWS::MetadataResponse
  end

  class DeleteLoadBalancerResponse < AWS::MetadataResponse
  end

  class DeleteLoadBalancerListenersResponse < AWS::MetadataResponse
  end

  class DeleteLoadBalancerPolicyResponse < AWS::MetadataResponse
  end

  class DeregisterInstancesFromLoadBalancerResponse < AWS::MetadataResponse
    struct "DeregisterInstancesFromLoadBalancerResult" do
      array "Instances" do
        field "InstanceId"
      end
    end
  end

  class DescribeInstanceHealthResponse < AWS::MetadataResponse
    struct "DescribeInstanceHealthResult" do
      array "InstanceStates" do
        field "Description"
        field "InstanceId"
        field "ReasonCode"
        field "State"
      end
    end
  end

  class DescribeLoadBalancerPoliciesResponse < AWS::MetadataResponse
    struct "DescribeLoadBalancerPoliciesResult" do
      array "PolicyDescriptions" do
        array "PolicyAttributeDescriptions" do
          field "AttributeName"
          field "AttributeValue"
        end
        field "PolicyName"
        field "PolicyTypeName"
      end
    end
  end

  class DescribeLoadBalancerPolicyTypesResponse < AWS::MetadataResponse
    struct "DescribeLoadBalancerPolicyTypesResult" do
      array "PolicyTypeDescriptions" do
        field "Description"
        array "PolicyAttributeTypeDescriptions" do
          field "AttributeName"
          field "AttributeValue"
          field "Cardinality"
          field "DefaultValue"
          field "Description"
        end
        field "PolicyTypeName"
      end
    end
  end

  class DescribeLoadBalancersResponse < AWS::MetadataResponse
    struct "DescribeLoadBalancersResult" do
      array "LoadBalancerDescriptions" do
        array "AvailabilityZones"
        array "BackendServerDescriptions" do
          field "InstancePort", Fixnum
          array "PolicyNames"
        end
        field "CanonicalHostedZoneName"
        field "CanonicalHostedZoneNameID"
        field "CreatedTime", DateTime
        field "DNSName"
        struct "HealthCheck" do
          field "HealthyThreshold", Fixnum
          field "Interval", Fixnum
          field "Target"
          field "Timeout", Fixnum
          field "UnhealthyThreshold", Fixnum
        end
        array "Instances" do
          field "InstanceId"
        end
        array "ListenerDescriptions" do
          struct "Listener" do
            field "InstancePort", Fixnum
            field "InstanceProtocol"
            field "LoadBalancerPort", Fixnum
            field "Protocol"
            field "SSLCertificateId"
          end
          array "PolicyNames"
        end
        field "LoadBalancerName"
        struct "Policies" do
          array "AppCookieStickinessPolicies" do
            field "CookieName"
            field "PolicyName"
          end
          array "LBCookieStickinessPolicies" do
            field "CookieExpirationPeriod", Bignum
            field "PolicyName"
          end
          array "OtherPolicies"
        end
        struct "SourceSecurityGroup" do
          field "GroupName"
          field "OwnerAlias"
        end
      end
    end
  end

  class DisableAvailabilityZonesForLoadBalancerResponse < AWS::MetadataResponse
    struct "DisableAvailabilityZonesForLoadBalancerResult" do
      array "AvailabilityZones"
    end
  end

  class EnableAvailabilityZonesForLoadBalancerResponse < AWS::MetadataResponse
    struct "EnableAvailabilityZonesForLoadBalancerResult" do
      array "AvailabilityZones"
    end
  end

  class RegisterInstancesWithLoadBalancerResponse < AWS::MetadataResponse
    struct "RegisterInstancesWithLoadBalancerResult" do
      array "Instances" do
        field "InstanceId"
      end
    end
  end

  class SetLoadBalancerListenerSSLCertificateResponse < AWS::MetadataResponse
  end

  class SetLoadBalancerPoliciesForBackendServerResponse < AWS::MetadataResponse
  end

  class SetLoadBalancerPoliciesOfListenerResponse < AWS::MetadataResponse
  end
end
