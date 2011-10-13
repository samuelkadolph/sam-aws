require "aws/cli/base"
require "r53"

module R53
  module CLI
    require "r53/cli/wait_for_change_to_sync"

    class Main < AWS::CLI::Base
      include WaitForChangeToSync

      namespace "r53"

      desc "create-hosted-zone NAME", ""
      method_option :reference
      method_option :comment
      can_wait_for_change_to_sync
      def create_hosted_zone(name)
        wait_for_change_to_sync { account.create_hosted_zone!(name, options.dup) }
      end

      desc "delete-hosted-zone ID", ""
      can_wait_for_change_to_sync
      def delete_hosted_zone(id)
        wait_for_change_to_sync { account.delete_hosted_zone!(id) }
      end

      desc "delete-resource-record-set ID NAME", ""
      def delete_resource_record_set(id, name)

      end

      desc "get-change ID", ""
      def get_change(id)
        change = account.get_change!(id).ChangeInfo
        puts change
      end

      desc "get-hosted-zone ID", ""
      def get_hosted_zone(id)
        result = account.get_hosted_zone!(id).HostedZone
      end

      desc "list-hosted-zones", ""
      def list_hosted_zones
        zones = account.list_all_hosted_zones!(options.dup)
        puts zones
      end

      desc "list-resource-record-sets ID", ""
      def list_resource_record_sets(id)
        sets = account.list_all_resource_record_sets!(id, options.dup)
        puts sets
      end

      protected
        def account
          R53::Account.new(access_key: access_key, secret_key: secret_key)
        end
    end
  end
end
