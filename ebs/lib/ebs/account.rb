module EBS
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::Versioning

    DEFAULT_OPTIONS = { endpoint: "https://elasticbeanstalk.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2010-12-01"

    option_reader :endpoint, :region

    def check_dns_availability(name)
      get("Action" => "CheckDNSAvailability", "CNAMEPrefix" => name)
    end
    bang :check_dns_availability

    def check_dns_availability?(*args)
      check_dns_availability!(*args).CheckDNSAvailabilityResult.Available == "true"
    end

    def create_application(name, description = nil)
      get("Action" => "CreateApplication", "ApplicationName" => name, "Description" => description)
    end
    bang :create_application

    def describe_applications
      get("Action" => "DescribeApplications")
    end
    bang :describe_applications
  end
end
