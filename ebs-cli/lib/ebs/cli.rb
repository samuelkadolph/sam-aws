require "aws/cli/base"
require "ebs"

module EBS
  module CLI
    class Main < AWS::CLI::Base
      namespace "ebs"

      desc "check-dns-availability NAME", "Checks if the specified CNAME is available"
      def check_dns_availability(name)
        if account.check_dns_availability?(name)
          say "'#{name}' is available"
          exit 0
        else
          say "'#{name}' is not available"
          exit 1
        end
      end

      desc "describe-applications", ""
      def describe_applications
        p account.describe_applications
      end

      protected
        def account
          EBS::Account.new(access_key: access_key, secret_key: secret_key)
        end
    end
  end
end
