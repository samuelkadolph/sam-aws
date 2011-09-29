require "aws"

module ELB
  VERSION = AWS::VERSION

  require "elb/account"
  require "elb/responses"
end
