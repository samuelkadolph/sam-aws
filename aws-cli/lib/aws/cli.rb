require "aws"
require "aws/cli/base"
require "ebs/cli"
require "ec2/cli"
require "elasticache/cli"
require "elb/cli"
require "r53/cli"
require "rds/cli"
require "s3/cli"
require "ses/cli"

module AWS
  module CLI
    class Main < Base
      desc "ebs", "Describe available Elastic Beanstalk commands or run a command"
      subcommand "ebs", EBS::CLI::Main

      desc "ec2", "Describe available Elastic Compute Cloud commands or run a command"
      subcommand "ec2", EC2::CLI::Main

      desc "elasticache", "Describe available ElastiCache commands or run a command"
      subcommand "elasticache", ElastiCache::CLI::Main

      desc "elb", "Describe available Elastic Load Balancer commands or run a command"
      subcommand "elb", ELB::CLI::Main

      desc "r53", "Describe available Route53 commands or run a command"
      subcommand "r53", R53::CLI::Main

      desc "rds", "Describe available Relational Database Service commands or run a command"
      subcommand "rds", RDS::CLI::Main

      # desc "s3", "Describe available S3 commands or run a command"
      # subcommand "s3", S3::CLI::Main

      desc "ses", "Describe available Simple Email Service commands or run a command"
      subcommand "ses", SES::CLI::Main

      desc "generate-credentials-file", "Generates a credentials file saved to the path given by --credentials"
      def generate_credentials_file
        create_file options[:credentials_file] do
          access_key, secret_key = ask("Access key:"), ask("Secret key:")
          "AWSAccessKeyId=#{access_key}\nAWSSecretKey=#{secret_key}\n"
        end
      end
    end
  end
end
