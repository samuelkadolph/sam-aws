require "aws"

module RDS
  VERSION = AWS::VERSION

  require "rds/account"
  require "rds/response"
  require "rds/responses"
end
