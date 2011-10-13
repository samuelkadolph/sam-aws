module ElastiCache
  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = { endpoint: "https://elasticache.%{region}.amazonaws.com", region: "us-east-1" }
    VERSION = "2011-07-15"

    def authorize_cache_security_group_ingress(group, options = {})
      auto "Action" => "AuthorizeCacheSecurityGroupIngress", "CacheSecurityGroupName" => group do
        option["EC2SecurityGroupName"] = options[:ec2_group]
        option["EC2SecurityGroupOwnerId"] = options[:ec2_group_owner]
      end
    end
    bang :authorize_cache_security_group_ingress

    def create_cache_cluster(id, options = {})
      auto "Action" => "CreateCacheCluster", "CacheClusterId" => id do
        option["AutoMinorVersionUpgrade"] = options[:auto_minor_upgrade]
        option["CacheNodeType"] = options[:type]
        option["CacheParameterGroupName"] = options[:parameter_group]
        array["CacheSecurityGroupNames"] = options[:security_groups]
        option["Engine"] = options[:engine]
        option["EngineVersion"] = options[:engine_version]
        option["NotificationTopicArn"] = options[:arn_topic]
        option["NumCacheNodes"] = options[:nodes]
        option["Port"] = options[:port]
        option["PreferredAvailabilityZone"] = options[:preferred_availability_zone]
        option["PreferredMaintenanceWindow"] = options[:preferred_maintenance_window]
      end
    end
    bang :create_cache_cluster

    def create_cache_parameter_group(name, family, description, options = {})
      auto "Action" => "CreateCacheParameterGroup", "CacheParameterGroupFamily" => family,
           "CacheParameterGroupName" => name, "Description" => description
    end
    bang :create_cache_parameter_group

    def create_cache_security_group(name, description, options = {})
      auto "Action" => "CreateCacheSecurityGroup", "CacheSecurityGroupName" => name, "Description" => description
    end
    bang :create_cache_security_group

    def delete_cache_cluster(id, options = {})
      auto "Action" => "DeleteCacheCluster", "CacheClusterId" => id
    end
    bang :delete_cache_cluster

    def delete_cache_parameter_group(name, options = {})
      auto "Action" => "DeleteCacheParameterGroup", "CacheParameterGroupName" => name
    end
    bang :delete_cache_parameter_group

    def delete_cache_security_group(name, options = {})
      auto "Action" => "DeleteCacheSecurityGroup", "CacheSecurityGroupName" => name
    end
    bang :delete_cache_security_group

    def describe_cache_clusters(options = {})
      auto "Action" => "DescribeCacheClusters" do
        option["CacheClusterId"] = options[:id]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        option["ShowCacheNodeInfo"] = options[:show_node_info]
      end
    end
    bang :describe_cache_clusters
    all :describe_cache_clusters

    def describe_cache_parameter_groups(options = {})
      auto "Action" => "DescribeCacheParameterGroups" do
        option["CacheParameterGroupName"] = options[:name]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_cache_parameter_groups
    all :describe_cache_parameter_groups

    def describe_cache_parameters(group, options = {})
      auto "Action" => "DescribeCacheParameters", "CacheParameterGroupName" => group do
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
        option["Source"] = options[:source]
      end
    end
    bang :describe_cache_parameters
    all :describe_cache_parameters

    def describe_cache_security_groups(options = {})
      auto "Action" => "DescribeCacheSecurityGroups" do
        option["CacheSecurityGroupName"] = options[:name]
        option["Marker"] = options[:marker]
        option["MaxRecords"] = options[:max_records]
      end
    end
    bang :describe_cache_security_groups
    all :describe_cache_security_groups

    def describe_engine_default_parameters(family, options = {})
      auto "Action" => "DescribeEngineDefaultParameters", "CacheParameterGroupFamily" => family do
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
        option["SourceIdentifier"] = options[:identifier]
        option["SourceType"] = options[:type]
        datetime["StartTime"] = options[:start]
      end
    end
    bang :describe_events

    def modify_cache_cluster(id, options = {})
      auto "Action" => "ModifyCacheCluster", "CacheClusterId" => id do
        option["ApplyImmediately"] = options[:apply_immediately]
        option["AutoMinorVersionUpgrade"] = options[:auto_minor_upgrade]
        array["CacheNodeIdsToRemove"] = options[:nodes_to_remove]
        option["CacheNodeType"] = options[:type]
        option["CacheParameterGroupName"] = options[:parameter_group]
        array["CacheSecurityGroupNames"] = options[:security_groups]
        option["EngineVersion"] = options[:engine_version]
        option["NotificationTopicArn"] = options[:arn_topic]
        option["NotificationTopicStatus"] = options[:arn_status_topic]
        option["NumCacheNodes"] = options[:nodes]
        option["PreferredMaintenanceWindow"] = options[:preferred_maintenance_window]
      end
    end
    bang :modify_cache_cluster

    def modify_cache_parameter_group(name, options = {})
      parameter_name_values = map_parameter_name_values(options[:parameter_name_values])

      auto "Action" => "ModifyCacheParameterGroup", "CacheParameterGroupName" => name do
        array.hash["ParameterNameValues"] = parameter_name_values
      end
    end
    bang :modify_cache_parameter_group

    def reboot_cache_cluster(cluster_id, node_ids, options = {})
      auto "Action" => "RebootCacheCluster", "CacheClusterId" => cluster_id do
        array["CacheNodeIdsToReboot"] = node_ids
      end
    end
    bang :reboot_cache_cluster

    def reset_cache_parameter_group(name, options = {})
      parameter_name_values = map_parameter_name_values(options[:parameter_name_values])

      auto "Action" => "ResetCacheParameterGroup", "CacheParameterGroupName" => name do
        array.hash["ParameterNameValues"] = parameter_name_values
        option["ResetAllParameters"] = options[:reset_all]
      end
    end
    bang :reset_cache_parameter_group

    def revoke_cache_security_group_ingress(group, options = {})
      auto "Action" => "RevokeCacheSecurityGroupIngress", "CacheSecurityGroupName" => group do
        option["EC2SecurityGroupName"] = options[:ec2_group]
        option["EC2SecurityGroupOwnerId"] = options[:ec2_group_owner]
      end
    end
    bang :revoke_cache_security_group_ingress

    private
      def map_parameter_name_values(parameter_name_values)
        case parameter_name_values
        when Array
          parameter_name_values.map { |name| { "ParameterName" => name, "ParameterValue" => nil } }
        when Hash
          parameter_name_values.map { |name, value| { "ParameterName" => name, "ParameterValue" => value } }
        end
      end
  end
end
