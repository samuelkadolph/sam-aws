require "aws/cli/base"
require "elb"

require "pry"

module ELB
  module CLI
    class Main < AWS::CLI::Base
      namespace "elb"

      desc "describe-load-balancers", "describe load balancers"
      def describe_load_balancers
        r = account.describe_load_balancers
        binding.pry
      end

      protected
        def account
          ELB::Account.new(access_key: access_key, secret_key: secret_key)
        end
    end
  end
end
