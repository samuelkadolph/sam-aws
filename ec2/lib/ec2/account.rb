module EC2
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = { endpoint: "https://ec2.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2011-07-15"

  end
end
