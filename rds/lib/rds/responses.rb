module RDS
  class AuthorizeDBSecurityGroupIngressResponse < Response
    struct :authorize_db_security_group_ingress_result do
      authorize_db_security_group_ingress_result
    end
  end

  class CreateDBInstanceResponse < Response
    struct :create_db_instance_result do
      create_db_instance_result
    end
  end

  class CreateDBInstanceReadReplicaResponse < Response
    struct :create_db_instance_read_replica_result do
      create_db_instance_read_replica_result
    end
  end

  class CreateDBParameterGroupResponse < Response
    struct :create_db_parameter_group_result do
      create_db_parameter_group_result
    end
  end

  class CreateDBSecurityGroupResponse < Response
    struct :create_db_security_group_result do
      create_db_security_group_result
    end
  end

  class CreateDBSnapshotResponse < Response
    struct :create_db_snapshot_result do
      create_db_snapshot_result
    end
  end

  class DeleteDBInstanceResponse < Response
    struct :delete_db_instance_result do
      delete_db_instance_result
    end
  end

  class DeleteDBParameterGroupResponse < Response
    struct :delete_db_parameter_group_result do
      delete_db_parameter_group_result
    end
  end

  class DeleteDBSecurityGroupResponse < Response
    struct :delete_db_security_group_result do
      delete_db_security_group_result
    end
  end

  class DeleteDBSnapshotResponse < Response
    struct :delete_db_snapshot_result do
      delete_db_snapshot_result
    end
  end

  class DescribeDBEngineVersionsResponse < Response
    struct :describe_db_engine_versions_result do
      describe_db_engine_versions_result
    end
  end

  class DescribeDBInstancesResponse < Response
    struct :describe_db_instances_result do
      describe_db_instances_result
    end
  end

  class DescribeDBParameterGroupsResponse < Response
    struct :describe_db_parameter_groups_result do
      describe_db_parameter_groups_result
    end
  end

  class DescribeDBParametersResponse < Response
    struct :describe_db_parameters_result do
      describe_db_parameters_result
    end
  end

  class DescribeDBSecurityGroupsResponse < Response
    struct :describe_db_security_groups_result do
      describe_db_security_groups_result
    end
  end

  class DescribeDBSnapshotsResponse < Response
    struct :describe_db_snapshots_result do
      describe_db_snapshots_result
    end
  end

  class DescribeEngineDefaultParametersResponse < Response
    struct :describe_engine_default_parameters_result do
      describe_engine_default_parameters_result
    end
  end

  class DescribeEventsResponse < Response
    struct :describe_events_result do
      describe_events_result
    end
  end

  class DescribeOrderableDBInstanceOptionsResponse < Response
    struct :describe_orderable_db_instance_options_result do
      describe_orderable_db_instance_options_result
    end
  end

  class DescribeReservedDBInstancesResponse < Response
    struct :describe_reserved_db_instances_result do
      describe_reserved_db_instances_result
    end
  end

  class DescribeReservedDBInstancesOfferingsResponse < Response
    struct :describe_reserved_db_instances_offerings_result do
      describe_reserved_db_instances_offerings_result
    end
  end

  class ModifyDBInstanceResponse < Response
    struct :modify_db_instance_result do
      modify_db_instance_result
    end
  end

  class ModifyDBParameterGroupResponse < Response
    struct :modify_db_parameter_group_result do
      modify_db_parameter_group_result
    end
  end

  class PurchaseReservedDBInstancesOfferingResponse < Response
    struct :purchase_reserved_db_instances_offering_result do
      purchase_reserved_db_instances_offering_result
    end
  end

  class RebootDBInstanceResponse < Response
    struct :reboot_db_instance_result do
      reboot_db_instance_result
    end
  end

  class ResetDBParameterGroupResponse < Response
    struct :reset_db_parameter_group_result do
      reset_db_parameter_group_result
    end
  end

  class RestoreDBInstanceFromDBSnapshotResponse < Response
    struct :restore_db_instance_from_db_snapshot_result do
      restore_db_instance_from_db_snapshot_result
    end
  end

  class RestoreDBInstanceToPointInTimeResponse < Response
    struct :restore_db_instance_to_point_in_time_result do
      restore_db_instance_to_point_in_time_result
    end
  end

  class RevokeDBSecurityGroupIngressResponse < Response
    struct :revoke_db_security_group_ingress_result do
      revoke_db_security_group_ingress_result
    end
  end
end
