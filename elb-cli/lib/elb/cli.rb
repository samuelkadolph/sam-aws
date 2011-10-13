require "aws/cli/base"
require "elb"

module ELB
  module CLI
    class Main < AWS::CLI::Base
      namespace "elb"

      protected
        def account
          ELB::Account.new(access_key: access_key, secret_key: secret_key)
        end
    end
  end
end
