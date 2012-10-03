require "aws/cli/base"
require "elasticache"

module ElastiCache
  module CLI
    class Main < AWS::CLI::Base
      namespace "elasticache"

      can_wait_until_done
      desc "authorize-cache-security-group-ingress GROUP", "Authorizes an EC2 security group"
      ec2_security_group_method_options
      def authorize_cache_security_group_ingress(group)
        options = ec2_security_group_method_options(self.options)

        result = account.authorize_cache_security_group_ingress!(group, options).result
        ec2_group = find_ec2_security_group(result.group.ec2_groups, options)

        wait_until_done(ec2_group, :status, "authorized") do
          result = account.describe_cache_security_groups!(name: group).result
          ec2_group = find_ec2_security_group(result.groups.first.ec2_groups, options)

          if ec2_group.status == "revoking"
            puts " ingress is being revoked!"
            return
          end

          ec2_group
        end
      end

      table_method_options
      can_wait_until_done
      desc "create-cache-cluster ID", "Creates a new cache cluster"
      method_option :arn_topic, aliases: "-a"
      method_option :auto_minor_upgrade, aliases: "", default: true, type: :boolean
      method_option :engine, aliases: "-e", default: "memcached"
      method_option :engine_version, aliases: "-E"
      method_option :nodes, aliases: "-n", required: true, type: :numeric
      method_option :parameter_group, aliases: "-G", banner: "GROUP"
      method_option :port, aliases: "-p", default: 11211, type: :numeric
      method_option :preferred_availability_zone, aliases: "-z"
      method_option :preferred_maintenance_window, aliases: "-w"
      method_option :security_groups, aliases: "-g", banner: "GROUP [GROUP...]", default: %W[default], type: :array
      method_option :type, aliases: "-t", default: "cache.m1.small"
      def create_cache_cluster(id)
        result = account.create_cache_cluster!(id, options).result
        tablize_cache_clusters([result.cluster]).print

        wait_until_done(result.cache_cluster) do
          result = account.describe_cache_clusters!(id: id).describe_cache_clusters_result
          result.cache_clusters.first
        end
      end

      table_method_options
      desc "create-cache-parameter-group FAMILY NAME DESCRIPTION", "Creates a new cache parameter group"
      def create_cache_parameter_group(family, name, description)
        result = account.create_cache_parameter_group!(family, name, description, options).result
        tableize_cache_parameter_groups([result.cache_parameter_group]).print
      end

      table_method_options
      desc "create-cache-security-group NAME DESCRIPTION", "Creates a new cache security group"
      def create_cache_security_group(name, description)
        result = account.create_cache_security_group!(name, description, options).result
        tableize_cache_security_groups([result.cache_security_group]).print
      end

      desc "delete-cache-cluster ID", "Deletes a cache cluster"
      def delete_cache_cluster(id)
        result = account.delete_cache_cluster!(id, options).delete_cache_cluster_result
        tableize_cache_clusters([result.cache_cluster]).print
      end

      desc "delete-cache-parameter-group NAME", "Deletes a cache parameter group"
      def delete_cache_parameter_group(name)
        account.delete_cache_parameter_group!(name, options)
      end

      desc "delete-cache-security-group NAME", "Deletes a cache security group"
      def delete_cache_security_group(name)
        account.delete_cache_security_group!(name, options)
      end

      show_all_method_options
      desc "describe-cache-clusters", "Describes all or one cache cluster"
      method_option :id
      method_option :max_records
      method_option :show_node_info, type: :boolean
      def describe_cache_clusters
        clusters = show_all(:describe_cache_clusters!, options)
        tableize_cache_clusters(clusters).print
      end

      show_all_method_options
      desc "describe-cache-parameter-groups", "Describes all or one cache parameter group"
      method_option :max_records
      method_option :name
      def describe_cache_parameter_groups
        groups = show_all(:describe_cache_parameter_groups!, options)
        tableize_cache_parameter_groups(groups).print
      end

      show_all_method_options
      desc "describe-cache-parameters GROUP", "Describes the parameters for a cache parameter group"
      method_option :max_records
      method_option :source
      def describe_cache_parameters(group)
        parameters = show_all(:describe_cache_parameters!, group, options)
        tableize_cache_parameters(parameters).print
      end

      show_all_method_options
      desc "describe-cache-security-groups", "Describe all or one cache security group"
      method_option :max_records
      method_option :name
      def describe_cache_security_groups
        groups = show_all(:describe_cache_security_groups!, options)
        tableize_cache_security_groups(groups).print
      end

      show_all_method_options
      desc "describe-engine-default-parameters FAMILY", "Describe the default parameters for a parameter group family"
      method_option :max_records
      def describe_engine_default_parameters(family)
        parameters = show_all(:describe_cache_parameters!, family, options)
        tableize_cache_parameters(parameters).print
      end

      show_all_method_options
      desc "describe-events", "Describe all events in the past 14 days"
      method_option :duration
      method_option :end
      method_option :max_records
      method_option :identifier
      method_option :start
      method_option :type
      def describe_events
        events = show_all(:describe_events, options)
        tableize_events(events).print
      end

      table_method_options
      # can_wait_until_done
      desc "modify-cache-cluster ID", "Modifies a cache cluster"
      method_option :apply_immediately, type: :boolean
      method_option :arn_topic, aliases: "-a"
      method_option :arn_status_topic, aliases: "-A"
      method_option :auto_minor_upgrade, aliases: "", type: :boolean
      method_option :engine_version, aliases: "-E"
      method_option :nodes, aliases: "-n", type: :numeric
      method_option :nodes_to_remove, aliases: "-N", type: :array
      method_option :parameter_group, aliases: "-G", banner: "GROUP"
      method_option :preferred_maintenance_window, aliases: "-w"
      method_option :security_groups, aliases: "-g", banner: "GROUP [GROUP...]", type: :array
      method_option :type, aliases: "-t", default: "cache.m1.small"
      def modify_cache_cluster(id)
        result = account.modify_cache_cluster!(id, options).result
        tableize_cache_clusters([result.cluster]).print

        # wait_until_done(result.cache_cluster) do
        #   result = account.describe_cache_clusters!(id: id).describe_cache_clusters_result
        #   result.cache_clusters.first
        # end
      end

      desc "modify-cache-parameter-group NAME", "Modifies a cache parameter group"
      method_option :parameter_name_values, aliases: "-p", required: true, type: :hash
      def modify_cache_parameter_group(name)
        account.modify_cache_parameter_group!(name, options)
      end

      desc "reboot-cache-cluster CLUSTERID NODEID [NODEID ...]", "Reboots a cache cluster's nodes"
      def reboot_cache_cluster(cluster_id, *node_ids)
        account.reboot_cache_cluster!(cluster_id, node_ids)
      end

      desc "reset-cache-parameter-group NAME", "Resets the values of a cache parameter group's parameter"
      method_option :parameter_name_values, aliases: "-p", required: true, type: :hash
      method_option :reset_all, aliases: "-a", default: false, type: :boolean
      def reset_cache_parameter_group(name)
        account.reset_cache_parameter_group!(name, options)
      end

      can_wait_until_done
      desc "revoke-cache-security-group-ingress GROUP", "Revokes an EC2 security group's access"
      ec2_security_group_method_options
      def revoke_cache_security_group_ingress(group)
        options = ec2_security_group_method_options(self.options)

        result = account.revoke_cache_security_group_ingress!(group, options).result
        ec2_group = find_ec2_security_group(result.group.ec2_groups, options)

        wait_until_done(ec2_group, :status, "revoked") do
          result = account.describe_cache_security_groups!(name: group).result
          find_ec2_security_group(result.groups.first.ec2_groups, options)
        end
      end

      protected
        def account
          ElastiCache::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def find_ec2_security_group(groups, options)
          groups.find do |group|
            group.name == options[:ec2_group] && group.owner == options[:ec2_group_owner]
          end
        end

        def tableize_cache_clusters(clusters)
          table do
            header "id", "create_time", "status", "nodes", "type", "engine", "parameter_group", "security_groups",
                   "availability_zone"
            clusters.each do |c|
              row c.id, c.create_time, c.status, c.num_nodes, c.type, c.engine, c.parameter_group.name,
                  c.security_groups.map(&:name).join(","), c.availability_zone
            end
          end
        end

        def tableize_cache_parameter_groups(groups)
        end

        def tableize_cache_parameters(parameters)
        end

        def tableize_cache_security_groups(groups)
          table do
          end
        end

        def tablelize_events(events)
        end
    end
  end
end
