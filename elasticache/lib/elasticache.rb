require "aws"

module ElastiCache
  VERSION = AWS::VERSION

  require "elasticache/account"
  require "elasticache/response"
  require "elasticache/responses"
end
