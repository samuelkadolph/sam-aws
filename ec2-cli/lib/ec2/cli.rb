require "aws/cli/base"
require "ec2"

module EC2
  module CLI
    class Main < AWS::CLI::Base
      namespace "ec2"

      desc "describe-instances", "describe-instances"
      def describe_instances(instance = nil)
        puts account.instances
      end

      protected
        def account
          EC2::Account.new(access_key: access_key, secret_key: secret_key)
        end
    end
  end
end
