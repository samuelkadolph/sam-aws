module ELB
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = { endpoint: "https://elasticloadbalancing.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2011-08-15"
  end
end
