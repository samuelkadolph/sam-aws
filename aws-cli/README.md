# sam-aws-cli

sam-aws-cli combines all of the sam-aws cli gems into one executable, called aws, with subcommands for each cli gem.

## Description

sam-aws-cli combines the sam-aws cli gems into one executable for convenience. Makes all of the cli gems available as
subcommands in an executable called aws.

## Installing

### Recommended

```
gem install sam-aws-cli
```

### Edge

```
git clone https://github.com/samuelkadolph/sam-aws
cd sam-aws/aws-cli && rake install
```

## Usage

```
Tasks:
  aws ebs                        # Describe available Elastic Beanstalk commands or run a command
  aws ec2                        # Describe available Elastic Compute Cloud commands or run a command
  aws elasticache                # Describe available ElastiCache commands or run a command
  aws elb                        # Describe available Elastic Load Balancer commands or run a command
  aws generate-credentials-file  # Generates a credentials file saved to the path given by --credentials
  aws help [TASK]                # Describe available tasks or one specific task
  aws r53                        # Describe available Route53 commands or run a command
  aws rds                        # Describe available Relational Database Service commands or run a command
  aws ses                        # Describe available Simple Email Service commands or run a command
  aws version                    # Prints the version of sam-aws

Options:
  -D, [--debug]                  # Enables debugging mode
  -V, [--verbose]                # Enables verbose mode
  -A, [--access-key=KEY]         # Specify the AWS access key to use
  -S, [--secret-key=KEY]         # Specify the AWS secret key to use
  -C, [--credentials-file=FILE]  # Override the path to the credentials file
                                 # Default: ~/.aws-credentials
```

## Requirements

### Credentials

See [/wiki/Credentials](/samuelkadolph/sam-aws/wiki/Credentials).

## Developers

### Contributing

See [/wiki/Contributing](/samuelkadolph/sam-aws/wiki/Contributing).
