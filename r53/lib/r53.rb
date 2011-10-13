require "aws"

module R53
  VERSION = AWS::VERSION

  require "r53/account"
  require "r53/errors"
  require "r53/response"
  require "r53/responses"
end
