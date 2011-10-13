# sam-elasticache-cli

sam-elasticache-cli includes an executable, called elasticache, for interacting with Amazon's ElastiCache.

## Description

DESC

## Usage

```
Tasks:
  elasticache authorize-cache-security-group-ingress GROUP -n, --ec2-group=NAME                           # Authorizes an EC2 security group
  elasticache create-cache-cluster ID -n, --nodes=N                                                       # Creates a new cache cluster
  elasticache create-cache-parameter-group FAMILY NAME DESCRIPTION                                        # Creates a new cache parameter group
  elasticache create-cache-security-group NAME DESCRIPTION                                                # Creates a new cache security group
  elasticache delete-cache-cluster ID                                                                     # Deletes a cache cluster
  elasticache delete-cache-parameter-group NAME                                                           # Deletes a cache parameter group
  elasticache delete-cache-security-group NAME                                                            # Deletes a cache security group
  elasticache describe-cache-clusters                                                                     # Describes all or one cache cluster
  elasticache describe-cache-parameter-groups                                                             # Describes all or one cache parameter group
  elasticache describe-cache-parameters GROUP                                                             # Describes the parameters for a cache parameter group
  elasticache describe-cache-security-groups                                                              # Describe all or one cache security group
  elasticache describe-engine-default-parameters FAMILY                                                   # Describe the default parameters for a parameter group family
  elasticache describe-events                                                                             # Describe all events in the past 14 days
  elasticache help [TASK]                                                                                 # Describe available tasks or one specific task
  elasticache modify-cache-cluster ID                                                                     # Modifies a cache cluster
  elasticache modify-cache-parameter-group NAME -p, --parameter-name-values=key:value                     # Modifies a cache parameter group
  elasticache reboot-cache-cluster CLUSTERID NODEID [NODEID ...]                                          # Reboots a cache cluster's nodes
  elasticache reset-cache-parameter-group NAME -p, --parameter-name-values=key:value                      # Resets the values of a cache parameter group's parameter
  elasticache revoke-cache-security-group-ingress GROUP -n, --ec2-group=NAME -o, --ec2-group-owner=OWNER  # Revokes an EC2 security group's access
  elasticache version                                                                                     # Prints the version of sam-aws

Options:
  -D, [--debug]                  # Enables debugging mode
  -V, [--verbose]                # Enables verbose mode
  -A, [--access-key=KEY]         # Specify the AWS access key to use
  -S, [--secret-key=KEY]         # Specify the AWS secret key to use
  -C, [--credentials-file=FILE]  # Override the path to the credentials file
                                 # Default: ~/.aws-credentials
```
