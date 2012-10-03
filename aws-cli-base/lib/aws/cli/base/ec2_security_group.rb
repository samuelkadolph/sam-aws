require "active_support/concern"

module AWS
  module CLI
    class Base
      module EC2SecurityGroup
        extend ActiveSupport::Concern

        module ClassMethods
          private
            def ec2_security_group_method_options(required = true)
              method_option :ec2_group, aliases: "-n", banner: "NAME", required: required, type: :string
              method_option :ec2_group_owner, aliases: "-o", banner: "OWNER", default: "self", type: :string
            end
        end

        def ec2_security_group(options)
          if options[:ec2_group_owner] == "self"
            options.merge(ec2_group_owner: account.account_id)
          else
            options
          end
        end
      end
    end
  end
end
