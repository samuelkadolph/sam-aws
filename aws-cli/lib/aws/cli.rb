require "aws"
require "ebs/cli"
require "ec2/cli"
require "rds/cli"
require "s3/cli"
require "thor"

module AWS
  module CLI
    class Main < Base
      desc "ebs", "Describe available EBS commands or run a command"
      subcommand "ebs", EBS::CLI::Main

      desc "ec2", "Describe available EC2 commands or run a command"
      subcommand "ec2", EC2::CLI::Main

      # desc "rds", "Describe available RDS commands or run a command"
      # subcommand "rds", RDS::CLI::Main
      #
      # desc "s3", "Describe available S3 commands or run a command"
      # subcommand "s3", S3::CLI::Main

      desc "generate-credentials-file", "Generates a credentials file saved to the path given by --credentials"
      def generate_credentials_file
        create_file options[:credentials_file] do
          "AWSAccessKeyId=#{ask "Access key:"}\nAWSSecretKey=#{ask "Secret key:"}\n"
        end
      end
    end
  end
end
