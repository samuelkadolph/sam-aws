require "aws"

module SES
  VERSION = AWS::VERSION

  require "ses/account"
  require "ses/courier"
  require "ses/responses"
end
