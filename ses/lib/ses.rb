require "aws"

module SES
  VERSION = AWS::VERSION

  require "ses/account"
  require "ses/courier"
  require "ses/response"
  require "ses/responses"
end
