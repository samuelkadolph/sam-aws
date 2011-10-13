require "aws"

module EBS
  VERSION = AWS::VERSION

  require "ebs/account"
  require "ebs/response"
  require "ebs/responses"
end
