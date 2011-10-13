module RDS
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = { endpoint: "https://rds.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2011-04-01"

    def authorize_db_security_group_ingress(group, options = {})
      auto "Action" => "AuthorizeDBSecurityGroupIngress", "DBSecurityGroupName" => group do
        option["CIDRIP"] = options[:cidrip]
        option["EC2SecurityGroupName"] = options[:ec2_group]
        option["EC2SecurityGroupOwnerId"] = options[:ec2_group_owner]
      end
    end
    bang :authorize_db_security_group_ingress

    def create_db_instance(id, options = {})
      auto "Action" => "CreateDBInstance", "DBInstanceIdentifier" => id do
        option["AllocatedStorage"] = options[:storage]
        boolean["AutoMinorVersionUpgrade"] = options[:auto_upgrade_minor_version]
        option["AvailabilityZone"] = options[:availability_zone]
        option["BackupRetentionPeriod"] = options[:backup_retention_period]
        option["DBInstanceClass"] = options[:class]
        option["DBName"] = options[:name]
        option["DBParameterGroupName"] = options[:parameter_group]
        array["DBSecurityGroups"] = options[:security_groups]
        option["Engine"] = options[:engine]
        option["EngineVersion"] = options[:engine_version]
        option["LicenseModel"] = options[:license_model]
        option["MasterUserPassword"] = options[:password]
        option["MasterUsername"] = options[:username]
        option["MultiAZ"] = options[:multi_az]
        option["Port"] = options[:port]
        option["PreferredBackupWindow"] = options[:preferred_backup_window]
        option["PreferredMaintenanceWindow"] = options[:preferred_maintenance_window]
      end
    end
    bang :create_db_instance

    def create_db_instance_read_replica(id, source, options = {})
      auto "Action" => "CreateDBInstance", "DBInstanceIdentifier" => id, "SourceDBInstanceIdentifier" => source do
        boolean["AutoMinorVersionUpgrade"] = options[:auto_upgrade_minor_version]
        option["AvailabilityZone"] = options[:availability_zone]
        option["DBInstanceClass"] = options[:class]
        option["Port"] = options[:port]
      end
    end
    bang :create_db_instance_read_replica

    def create_db_parameter_group(name, family, options = {})
      auto "Action" => "CreateDBParameterGroup", "DBParameterGroupFamily" => family, "DBParameterGroupName" => name do
        option["Description"] = options[:description]
      end
    end
    bang :create_db_parameter_group

    def create_db_security_group(name, options = {})
      auto "Action" => "CreateDBSecurityGroup", "DBSecurityGroupName" => name do
        option["DBSecurityGroupDescription"] = options[:description]
      end
    end
    bang :create_db_security_group

    def create_db_snapshot(instance_id, snapshot_id, options = {})
      auto "Action" => "CreateDBSnapshot", "DBInstanceIdentifier" => instance_id, "DBSnapshotIdentifier" => snapshot_id
    end
    bang :create_db_snapshot

    def delete_db_instance(id, options = {})
      auto "Action" => "DeleteDBInstance", "DBInstanceIdentifier" => id do
        option["FinalDBSnapshotIdentifier"] = options[:final_snapshot_id]
        boolean["SkipFinalSnapshot"] = options[:skip_final_snapshot]
      end
    end
    bang :delete_db_instance

    def delete_db_parameter_group(name, options = {})
      auto "Action" => "DeleteDBParameterGroup", "DBParameterGroupName" => name
    end
    bang :delete_db_parameter_group

    def delete_db_security_group(name, options = {})
      auto "Action" => "DeleteDBSecurityGroup", "DBSecurityGroupName" => name
    end
    bang :delete_db_security_group

    def delete_db_snapshot(id, options = {})
      auto "Action" => "DeleteDBSnapshot", "DBSnapshotIdentifier" => id
    end
    bang :delete_db_snapshot

    def describe_db_engine_versions(options = {})
      auto "Action" => "DescribeDBEngineVersions" do
        option["DBParameterGroupFamily"] = options[:parameter_family]
        boolean["DefaultOnly"] = options[:default_only]
        option["Engine"] = options[:engine]
        option["EngineVersion"] = options[:engine_version]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_db_engine_versions
    all :describe_db_engine_versions

    def describe_db_instances(options = {})
      auto "Action" => "DescribeDBInstances" do
        option["DBInstanceIdentifier"] = options[:id]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_db_instances
    all :describe_db_instances

    def describe_db_parameter_groups(options = {})
      auto "Action" => "DescribeDBParameterGroups" do
        option["DBParameterGroupName"] = options[:name]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_db_parameter_groups
    all :describe_db_parameter_groups

    def describe_db_parameters(options = {})
      auto "Action" => "DescribeDBParameters" do
        option["DBParameterGroupName"] = options[:name]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        option["Source"] = options[:source]
      end
    end
    bang :describe_db_parameters
    all :describe_db_parameters

    def describe_db_security_groups(options = {})
      auto "Action" => "DescribeDBSecurityGroups" do
        option["DBSecurityGroupName"] = options[:name]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_db_security_groups
    all :describe_db_security_groups

    def describe_db_snapshots(options = {})
      auto "Action" => "DescribeDBSnapshots" do
        option["DBInstanceIdentifier"] = options[:instance_id]
        option["DBSnapshotIdentifier"] = options[:id]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_db_snapshots
    all :describe_db_snapshots

    def describe_engine_default_parameters(options = {})
      auto "Action" => "DescribeEngineDefaultParameters" do
        option["DBParameterGroupFamily"] = options[:parameter_family]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_engine_default_parameters
    all :describe_engine_default_parameters

    def describe_events(options = {})
      auto "Action" => "DescribeEvents" do
        option["Duration"] = options[:duration]
        datetime["EndTime"] = options[:end]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        option["SourceIdentifier"] = options[:id]
        option["SourceType"] = options[:type]
        datetime["StartTime"] = options[:start]
      end
    end
    bang :describe_events
    all :describe_events

    def describe_orderable_db_instance_options(engine, options = {})
      auto "Action" => "DescribeOrderableDBInstanceOptions", "Engine" => engine do
        option["DBInstanceClass"] = options[:class]
        option["EngineVersion"] = options[:engine_version]
        option["LicenseModel"] = options[:license]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_orderable_db_instance_options
    all :describe_orderable_db_instance_options

    def describe_reserved_db_instances(options = {})
      auto "Action" => "DescribeReservedDBInstances" do
        option["DBInstanceClass"] = options[:class]
        option["Duration"] = options[:duration]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        boolean["MultiAZ"] = options[:multi_az]
        option["ProductDescription"] = options[:description]
        option["ReservedDBInstanceId"] = options[:instance_id]
        option["ReservedDBInstancesOfferingId"] = options[:instance_offering_id]
      end
    end
    bang :describe_reserved_db_instances
    all :describe_reserved_db_instances

    def describe_reserved_db_instances_offerings(options = {})
      auto "Action" => "DescribeReservedDBInstancesOfferings" do
        option["DBInstanceClass"] = options[:class]
        option["Duration"] = options[:duration]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        boolean["MultiAZ"] = options[:multi_az]
        option["ProductDescription"] = options[:description]
        option["ReservedDBInstancesOfferingId"] = options[:instance_offering_id]
      end
    end
    bang :describe_reserved_db_instances_offerings
    all :describe_reserved_db_instances_offerings

    def modify_db_instance(id, options = {})
      auto "Action" => "ModifyDBInstance", "DBInstanceIdentifier" => id do
        option["AllocatedStorage"] = options[:storage]
        boolean["AllowMajorVersionUpgrade"] = options[:allow_major_version_upgrade]
        boolean["ApplyImmediately"] = options[:apply_immediately]
        boolean["AutoMinorVersionUpgrade"] = options[:auto_upgrade_minor_version]
        option["BackupRetentionPeriod"] = options[:backup_retention_period]
        option["DBInstanceClass"] = options[:class]
        option["DBParameterGroupName"] = options[:parameter_group]
        array["DBSecurityGroups"] = options[:security_groups]
        option["EngineVersion"] = options[:engine_version]
        option["MasterUserPassword"] = options[:password]
        option["MultiAZ"] = options[:multi_az]
        option["Port"] = options[:port]
        option["PreferredBackupWindow"] = options[:preferred_backup_window]
        option["PreferredMaintenanceWindow"] = options[:preferred_maintenance_window]
      end
    end
    bang :modify_db_instance

    def modify_db_parameter_group(name, options = {})
      parameters = map_parameter_list(options[:parameters])
      auto "Action" => "ModifyDBParameterGroup", "DBParameterGroupName" => name do
        array.hash["Parameters"] = parameters
      end
    end
    bang :modify_db_parameter_group

    def purchase_reserved_db_instances_offering(id, options = {})
      auto "Action" => "PurchaseReservedDBInstancesOffering", "ReservedDBInstancesOfferingId" => id do
        option["DBInstanceCount"] = options[:count]
        option["ReservedDBInstanceId"] = options[:instance_id]
      end
    end
    bang :purchase_reserved_db_instances_offering

    def reboot_db_instance(id, options = {})
      auto "Action" => "RebootDBInstance", "DBInstanceIdentifier" => id
    end
    bang :reboot_db_instance

    def reset_db_parameter_group(options = {})
      parameters = map_parameter_list(options[:parameters])
      auto "Action" => "ResetDBParameterGroup", "DBParameterGroupName" => name do
        array.hash["Parameters"] = parameters
        boolean["ResetAllParameters"] = options[:reset_all]
      end
    end
    bang :reset_db_parameter_group

    def restore_db_instance_from_db_snapshot(id, instance_id, options = {})
      auto "Action" => "RestoreDBInstanceFromDBSnapshot", "DBInstanceIdentifier" => instance_id, "DBSnapshotIdentifier" => id do
        boolean["AutoMinorVersionUpgrade"] = options[:auto_upgrade_minor_version]
        option["AvailabilityZone"] = options[:availability_zone]
        option["DBInstanceClass"] = options[:class]
        option["DBName"] = options[:name]
        option["Engine"] = options[:engine]
        option["LicenseModel"] = options[:license_model]
        option["MultiAZ"] = options[:multi_az]
        option["Port"] = options[:port]
      end
    end
    bang :restore_db_instance_from_db_snapshot

    def restore_db_instance_to_point_in_time(source_id, target_id, options = {})
      auto "Action" => "RestoreDBInstanceToPointInTime", "SourceDBInstanceIdentifier" => source_id, "TargetDBInstanceIdentifier" => target_id do
        boolean["AutoMinorVersionUpgrade"] = options[:auto_upgrade_minor_version]
        option["AvailabilityZone"] = options[:availability_zone]
        option["DBInstanceClass"] = options[:class]
        option["DBName"] = options[:name]
        option["Engine"] = options[:engine]
        option["LicenseModel"] = options[:license_model]
        option["MultiAZ"] = options[:multi_az]
        option["Port"] = options[:port]
        datetime["RestoreTime"] = options[:restore_time]
        boolean["UseLatestRestorableTime"] = options[:use_latest_restorable_time]
      end    end
    bang :restore_db_instance_to_point_in_time

    def revoke_db_security_group_ingress(group, options = {})
      auto "Action" => "RevokeDBSecurityGroupIngress", "DBSecurityGroupName" => group do
        option["CIDRIP"] = options[:cidrip]
        option["EC2SecurityGroupName"] = options[:ec2_group]
        option["EC2SecurityGroupOwnerId"] = options[:ec2_group_owner]
      end
    end
    bang :revoke_db_security_group_ingress
  end
end
