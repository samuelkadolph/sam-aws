module ELB
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::Versioning

    DEFAULT_OPTIONS = { endpoint: "https://elasticloadbalancing.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2011-08-15"

    option_reader :endpoint, :region

    def describe_load_balancers
      get("Action" => "DescribeLoadBalancers")
    end
    bang :describe_load_balancers

  end
end
