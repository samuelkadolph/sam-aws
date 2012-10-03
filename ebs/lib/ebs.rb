require "aws"

# elasticbeanstalk
module EBS
  VERSION = AWS::VERSION

  require "ebs/account"
  require "ebs/errors"
  require "ebs/responses"
  require "ebs/types"
end
