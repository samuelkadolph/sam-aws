require "aws/response"

module ElastiCache
  AWS::ABSTRACT_RESPONSES << "ElastiCache::Response"

  class Response < AWS::MetadataResponse
    class << self
      private
        def authorize_cache_security_group_ingress_result
          struct :cache_security_group, :group do
            cache_security_group
          end
        end

        def cache_cluster
          field :auto_minor_version_upgrade, :auto_upgrade_minor_version, :boolean
          field :cache_cluster_create_time, :create_time, DateTime
          field :cache_cluster_id, :id
          field :cache_cluster_status, :status
          field :cache_node_type, :type
          array :cache_nodes, :nodes do
            cache_node
          end
          struct :cache_parameter_group, :parameter_group do
            cache_parameter_group_status
          end
          array :cache_security_groups, :security_groups do
            cache_security_group_membership
          end
          field :engine
          field :engine_version
          struct :notification_configuration do
            notification_configuration
          end
          field :num_cache_nodes, :num_nodes, Fixnum
          struct :pending_modified_values do
            pending_modified_values
          end
          field :preferred_availability_zone, :availability_zone
          field :preferred_maintenance_window, :maintenance_window
        end

        def cache_node
          field :cache_node_create_time, :create_time, DateTime
          field :cache_node_id, :id
          field :cache_node_status, :status
          struct :endpoint do
            endpoint
          end
          field :parameter_group_status
        end

        def cache_node_type_specific_parameter
          field :allowed_values
          array :cache_node_type_specific_values do
            cache_node_type_specific_value
          end
          field :data_type
          field :description
          field :is_modifiable, :boolean
          field :minimum_engine_version
          field :parameter_name
          field :source
        end

        def cache_node_type_specific_value
          field :cache_node_type, :type
          field :value
        end

        def cache_parameter_group
          field :cache_parameter_group_family, :parameter_family
          field :cache_parameter_group_name, :parameter_name
          field :description
        end

        def cache_parameter_group_status
          field :cache_node_ids_to_reboot, :ids_to_reboot
          field :cache_parameter_group_name, :name
          field :parameter_apply_status, :status
        end

        def cache_security_group
          field :cache_security_group_name, :name
          field :description
          array :ec2_security_groups, :ec2_groups do
            ec2_security_group
          end
          field :owner_id, :owner
        end

        def cache_security_group_membership
          field :cache_security_group_name, :name
          field :status
        end

        def create_cache_cluster_result
          struct :cache_cluster, :cluster do
            cache_cluster
          end
        end

        def create_cache_parameter_group_result
          struct :cache_parameter_group, :group do
            cache_parameter_group
          end
        end

        def create_cache_security_group_result
          struct :cache_security_group, :group do
            cache_security_group
          end
        end

        alias delete_cache_cluster_result create_cache_cluster_result

        def delete_cache_parameter_group_result
        end

        def delete_cache_security_group_result
        end

        def describe_cache_clusters_result
          array :cache_clusters, :clusters do
            cache_cluster
          end
          field :marker
        end

        def describe_cache_parameter_groups_result
          array :cache_parameter_groups, :groups do
            cache_parameter_group
          end
          field :marker
        end

        def describe_cache_parameters_result
          array :cache_node_type_specific_parameters do
            cache_node_type_specific_parameter
          end
          field :marker
          array :parameters do
            parameter
          end
        end

        def describe_cache_security_groups_result
          array :cache_security_groups, :groups do
            cache_security_group
          end
          field :marker
        end

        def describe_engine_default_parameters_result
          struct :engine_defaults do
            engine_defaults
          end
        end

        def describe_events_result
          array :events do
            event
          end
          field :marker
        end

        def ec2_security_group
          field :ec2_security_group_name, :name, Fixnum
          field :ec2_security_group_owner_id, :owner
          field :status
        end

        def endpoint
          field :address
          field :port, Fixnum
        end

        def engine_defaults
          array :cache_node_type_specific_parameters do
            cache_node_type_specific_parameter
          end
          field :cache_parameter_group_family, :parameter_family
          field :marker
          array :parameters do
            parameter
          end
        end

        def event
          field :date, DateTime
          field :message
          field :source_identifier, :source
          field :source_type, %W[cache-cluster cache-parameter-group cache-security-group]
        end

        alias modify_cache_cluster_result create_cache_cluster_result

        def modify_cache_parameter_group_result
          field :cache_parameter_group_name
        end

        def notification_configuration
          field :topic_arn
          field :topic_status
        end

        def parameter
          field :allowed_values
          field :data_type
          field :description
          field :is_modifiable, :boolean
          field :minimum_engine_version
          field :parameter_name
          field :parameter_value
          field :source
        end

        def parameter_name_value
          field :parameter_name
          field :parameter_value
        end

        def pending_modified_values
          array :cache_node_ids_to_removes
          field :engine_version
          field :num_cache_nodes, Fixnum
        end

        alias reboot_cache_cluster_result create_cache_cluster_result

        def reset_cache_parameter_group_result
          field :cache_parameter_group_name
        end

        alias revoke_cache_security_group_ingress_result authorize_cache_security_group_ingress_result
    end
  end
end
