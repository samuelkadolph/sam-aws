require "aws"

module ELB
  VERSION = AWS::VERSION

  require "elb/account"
  require "elb/response"
  require "elb/responses"
end
