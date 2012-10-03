require "aws/cli/base"
require "rds"

module RDS
  module CLI
    class Main < AWS::CLI::Base
      namespace "rds"

      desc "authorize-db-security-group-ingress GROUP", ""
      ec2_security_group_method_options(false)
      method_option :cidrip
      method_option :self
      def authorize_db_security_group_ingress(group)
        if options[:self]
          error = account.authorize_db_security_group_ingress(group).error
          cidrip = error.message =~ %r[(\d{1,3}(\.\d{1,3}){3}/\d{1,2})] && $1
          account.authorize_db_security_group_ingress(group, cidrip: cidrip)
        else
          options = ec2_security_group_method_options(self.options)
          account.authorize_db_security_group_ingress!(options)
        end
      end

      desc "create-db-instance", ""
      def create_db_instance
        account.create_db_instance!(options)
      end

      desc "create-db-instance-read-replica", ""
      def create_db_instance_read_replica
        account.create_db_instance_read_replica!(options)
      end

      desc "create-db-parameter-group", ""
      def create_db_parameter_group
        account.create_db_parameter_group!(options)
      end

      desc "create-db-security-group", ""
      def create_db_security_group
        account.create_db_security_group!(options)
      end

      desc "create-db-snapshot", ""
      def create_db_snapshot
        account.create_db_snapshot!(options)
      end

      desc "delete-db-instance", ""
      def delete_db_instance
        account.delete_db_instance!(options)
      end

      desc "delete-db-parameter-group", ""
      def delete_db_parameter_group
        account.delete_db_parameter_group!(options)
      end

      desc "delete-db-security-group", ""
      def delete_db_security_group
        account.delete_db_security_group!(options)
      end

      desc "delete-db-snapshot", ""
      def delete_db_snapshot
        account.delete_db_snapshot!(options)
      end

      desc "describe-db-engine-versions", ""
      def describe_db_engine_versions
        account.describe_db_engine_versions!(options)
      end

      desc "describe-db-instances", ""
      def describe_db_instances
        account.describe_db_instances!(options)
      end

      desc "describe-db-parameter-groups", ""
      def describe_db_parameter_groups
        account.describe_db_parameter_groups!(options)
      end

      desc "describe-db-parameters", ""
      def describe_db_parameters
        account.describe_db_parameters!(options)
      end

      desc "describe-db-security-groups", ""
      def describe_db_security_groups
        account.describe_db_security_groups!(options)
      end

      desc "describe-db-snapshots", ""
      def describe_db_snapshots
        account.describe_db_snapshots!(options)
      end

      desc "describe-engine-default-parameters", ""
      def describe_engine_default_parameters
        account.describe_engine_default_parameters!(options)
      end

      desc "describe-events", ""
      def describe_events
        account.describe_events!(options)
      end

      desc "describe-orderable-db-instance-options", ""
      def describe_orderable_db_instance_options
        account.describe_orderable_db_instance_options!(options)
      end

      desc "describe-reserved-db-instances", ""
      def describe_reserved_db_instances
        account.describe_reserved_db_instances!(options)
      end

      desc "describe-reserved-db-instances-offerings", ""
      def describe_reserved_db_instances_offerings
        account.describe_reserved_db_instances_offerings!(options)
      end

      desc "modify-db-instance", ""
      def modify_db_instance
        account.modify_db_instance!(options)
      end

      desc "modify-db-parameter-group", ""
      def modify_db_parameter_group
        account.modify_db_parameter_group!(options)
      end

      desc "purchase-reserved-db-instances-offering", ""
      def purchase_reserved_db_instances_offering
        account.purchase_reserved_db_instances_offering!(options)
      end

      desc "reboot-db-instance", ""
      def reboot_db_instance
        account.reboot_db_instance!(options)
      end

      desc "reset-db-parameter-group", ""
      def reset_db_parameter_group
        account.reset_db_parameter_group!(options)
      end

      desc "restore-db-instance-from-db-snapshot", ""
      def restore_db_instance_from_db_snapshot
        account.restore_db_instance_from_db_snapshot!(options)
      end

      desc "restore-db-instance-to-point-in-time", ""
      def restore_db_instance_to_point_in_time
        account.restore_db_instance_to_point_in_time!(options)
      end

      desc "revoke-db-security-group-ingress", ""
      ec2_security_group_method_options(false)
      method_option :cidrip
      method_option :self
      def revoke_db_security_group_ingress(group)
        if options[:self]
          error = account.revoke_db_security_group_ingress(group).error
          cidrip = error.message =~ %r[(\d{1,3}(\.\d{1,3}){3}/\d{1,2})] && $1
          account.revoke_db_security_group_ingress(group, cidrip: cidrip)
        else
          options = ec2_security_group_method_options(self.options)
          account.revoke_db_security_group_ingress!(options)
        end
      end

      protected
        def account
          RDS::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def tablize_db_instances(instances)
          table do
          end
        end
    end
  end
end
