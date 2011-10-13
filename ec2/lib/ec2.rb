require "aws"

module EC2
  VERSION = AWS::VERSION

  require "ec2/account"
  require "ec2/response"
  require "ec2/responses"
end
