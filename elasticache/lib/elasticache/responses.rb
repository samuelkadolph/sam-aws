module ElastiCache
  class AuthorizeCacheSecurityGroupIngressResponse < Response
    struct :authorize_cache_security_group_ingress_result do
      authorize_cache_security_group_ingress_result
    end
  end

  class CreateCacheClusterResponse < Response
    struct :create_cache_cluster_result do
      create_cache_cluster_result
    end
  end

  class CreateCacheParameterGroupResponse < Response
    struct :create_cache_parameter_group_result do
      create_cache_parameter_group_result
    end
  end

  class CreateCacheSecurityGroupResponse < Response
    struct :create_cache_security_group_result do
      create_cache_security_group_result
    end
  end

  class DeleteCacheClusterResponse < Response
    struct :delete_cache_cluster_result do
      delete_cache_cluster_result
    end
  end

  class DeleteCacheParameterGroupResponse < Response
    struct :delete_cache_parameter_group_result do
      delete_cache_parameter_group_result
    end
  end

  class DeleteCacheSecurityGroupResponse < Response
    struct :delete_cache_security_group_result do
      delete_cache_security_group_result
    end
  end

  class DescribeCacheClustersResponse < Response
    struct :describe_cache_clusters_result do
      describe_cache_clusters_result
    end
  end

  class DescribeCacheParameterGroupsResponse < Response
    struct :describe_cache_parameter_groups_result do
      describe_cache_parameter_groups_result
    end
  end

  class DescribeCacheParametersResponse < Response
    struct :describe_cache_parameters_result do
      describe_cache_parameters_result
    end
  end

  class DescribeCacheSecurityGroupsResponse < Response
    struct :describe_cache_security_groups_result do
      describe_cache_security_groups_result
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

  class ModifyCacheClusterResponse < Response
    struct :modify_cache_cluster_result do
      modify_cache_cluster_result
    end
  end

  class ModifyCacheParameterGroupResponse < Response
    struct :modify_cache_parameter_group_result do
      modify_cache_parameter_group_result
    end
  end

  class RebootCacheClusterResponse < Response
    struct :reboot_cache_cluster_result do
      reboot_cache_cluster_result
    end
  end

  class ResetCacheParameterGroupResponse < Response
    struct :reset_cache_parameter_group_result do
      reset_cache_parameter_group_result
    end
  end

  class RevokeCacheSecurityGroupIngressResponse < Response
    struct :revoke_cache_security_group_ingress_result do
      revoke_cache_security_group_ingress_result
    end
  end
end
