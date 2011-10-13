require "aws/response"

module RDS
  AWS::ABSTRACT_RESPONSES << "RDS::Response"

  class Response < AWS::MetadataResponse
    class << self
      private
        def authorize_db_security_group_ingress_result
          struct :db_security_group, :group do
            db_security_group
          end
        end

        def availability_zone
          field :name
        end

        def create_db_instance_read_replica_result
          struct :db_instance, :instance do
            db_instance
          end
        end

        alias create_db_instance_result create_db_instance_read_replica_result

        def create_db_parameter_group_result
          struct :db_parameter_group, :group do
            db_parameter_group
          end
        end

        def create_db_security_group_result
          struct :db_security_group, :group do
            db_security_group
          end
        end

        def create_db_snapshot_result
          struct :db_snapshot, :snapshot do
            db_snapshot
          end
        end

        def db_engine_version
          field :db_engine_description, :description
          field :db_engine_version_description, :version_description
          field :db_parameter_group_family, :parameter_family
          field :engine
          field :engine_version
        end

        def db_instance
          field :allocated_storage, :storage, Fixnum
          field :auto_minor_version_upgrade, :auto_upgrade_minor_version, :boolean
          field :availability_zone
          field :backup_retention_period, Fixnum
          field :db_instance_class, :instance_class
          field :db_instance_identifier, :instance_id
          field :db_instance_status, :instance_status
          field :db_name, :name
          array :db_parameter_groups, :parameter_groups do
            db_parameter_group_status
          end
          array :db_security_groups, :security_groups do
            db_security_group_membership
          end
          struct :endpoint do
            endpoint
          end
          field :engine
          field :engine_version
          field :instance_create_time, :create_time, DateTime
          field :latest_restorable_time, :restorable_time, DateTime
          field :license_model, :license
          field :master_username, :username
          field :multi_az, :boolean
          struct :pending_modified_values do
            pending_modified_values
          end
          field :preferred_backup_window, :backup_window
          field :preferred_maintenance_window, :maintenance_window
          array :read_replica_db_instance_identifiers, :read_replicas
          field :read_replica_source_db_instance_identifier, :read_replica_source
        end

        def db_parameter_group
          field :db_parameter_group_family, :parameter_family
          field :db_parameter_group_name, :name
          field :description
        end

        def db_parameter_group_status
          field :db_parameter_group_name, :name
          field :parameter_apply_status, :status
        end

        def db_security_group
          field :db_security_group_description, :description
          field :db_security_group_name, :name
          array :ec2_security_groups, :ec2_groups do
            ec2_security_group
          end
          array :ip_ranges do
            ip_range
          end
          field :owner_id, :owner
        end

        def db_security_group_membership
          field :db_security_group_name, :name
          field :status
        end

        def db_snapshot
          field :allocated_storage, :storage, Fixnum
          field :availability_zone
          field :db_instance_identifier, :instance_id
          field :db_snapshot_identifier, :snapshot_id, :id
          field :engine
          field :engine_version
          field :instance_create_time, DateTime
          field :license_model, :license
          field :master_username, :username
          field :port, Fixnum
          field :snapshot_create_time, :create_time, DateTime
          field :status
        end

        alias delete_db_instance_result create_db_instance_result

        alias delete_db_parameter_group_result create_db_parameter_group_result

        alias delete_db_security_group_result create_db_security_group_result

        alias delete_db_snapshot_result create_db_snapshot_result

        def describe_db_engine_versions_result
          array :db_engine_versions, :versions do
            db_engine_version
          end
          field :marker
        end

        def describe_db_instances_result
          array :db_instances, :instances do
            db_instance
          end
          field :marker
        end

        def describe_db_parameter_groups_result
          array :db_parameter_groups, :groups do
            db_parameter_group
          end
          field :marker
        end

        def describe_db_parameters_result
          field :marker
          array :parameters do
            parameter
          end
        end

        def describe_db_security_groups_result
          array :db_security_groups, :groups do
            db_security_group
          end
          field :marker
        end

        def describe_db_snapshots_result
          array :db_snapshots, :snapshots do
            db_snapshot
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

        def describe_orderable_db_instance_options_result
          field :marker
          array :orderable_db_instance_options, :options do
            orderable_db_instance_option
          end
        end

        def describe_reserved_db_instances_offerings_result
          field :marker
          array :reserved_db_instance_offerings, :instances do
            reserved_db_instance_offering
          end
        end

        def describe_reserved_db_instances_result
          field :marker
          array :reserved_db_instance, :instances do
            reserved_db_instance
          end
        end

        def ec2_security_group
          field :ec2_security_group_name, :name
          field :ec2_security_group_owner_id, :owner
          field :status
        end

        def endpoint
          field :address
          field :port, Fixnum
        end

        def engine_defaults
          field :db_parameter_group_family, :parameter_family
          field :marker
          array :parameters do
            parameter
          end
        end

        def event
          field :date, DateTime
          field :message
          field :source_identifier, :source
          field :source_type, :type, %W[db-instance db-parameter-group db-security-group db-snapshot]
        end

        def ip_range
          field :cidrip
          field :status
        end

        alias modify_db_instance_result create_db_instance_result

        def modify_db_parameter_group_result
          field :db_parameter_group_name, :name
        end

        def orderable_db_instance_option
          array :availability_zones do
            availability_zone
          end
          field :db_instance_class, :instance_class
          field :engine
          field :engine_version
          field :license_model, :license
          field :multi_az_capable, :boolean
          field :read_replica_capable, :boolean
        end

        def parameter
          field :allowed_values
          field :apply_method, %W[immediate pending-reboot]
          field :apply_type
          field :data_type
          field :description
          field :is_modifiable, :boolean
          field :minimum_engine_version
          field :parameter_name, :name
          field :parameter_value, :value
          field :source
        end

        def pending_modified_values
          field :allocated_storage, :storage, Fixnum
          field :backup_retention_period, Fixnum
          field :db_instance_class, :instance_class
          field :engine_version
          field :master_user_password, :password
          field :multi_az, :boolean
          field :port, Fixnum
        end

        def purchase_reserved_db_instances_offering_result
          struct :reserved_db_instance do
            reserved_db_instance
          end
        end

        alias reboot_db_instance_result create_db_instance_result

        def reserved_db_instance
          field :currency_code
          field :db_instance_class, :instance_class
          field :db_instance_count, :instance_count, Fixnum
          field :duration, Fixnum
          field :fixed_price, Float
          field :multi_az, :boolean
          field :product_description, :description
          field :reserved_db_instance_id, :id
          field :reserved_db_instance_offering_id, :offering_id
          field :start_time, :start, DateTime
          field :state
          field :usage_price, Float
        end

        def reserved_db_instance_offering
          field :currency_code
          field :db_instance_class, :instance_class
          field :duration, Fixnum
          field :fixed_price, Float
          field :multi_az, :boolean
          field :product_description, :description
          field :reserved_db_instance_offering_id, :offering_id
          field :usage_price, Float
        end

        alias reset_db_parameter_group_result modify_db_parameter_group_result

        alias restore_db_instance_from_db_snapshot_result create_db_instance_result

        alias restore_db_instance_to_point_in_time_result create_db_instance_result

        alias revoke_db_security_group_ingress_result authorize_db_security_group_ingress_result
    end
  end
end
