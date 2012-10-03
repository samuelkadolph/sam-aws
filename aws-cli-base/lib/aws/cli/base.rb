require "aws"
require "proxifier/env"
require "thor"

module AWS
  module CLI
    class Base < Thor
      require "aws/cli/base/all"
      require "aws/cli/base/ec2_security_group"
      require "aws/cli/base/tables"
      require "aws/cli/base/types"
      require "aws/cli/base/waiting"

      include Actions
      include All
      include EC2SecurityGroup
      include Tables
      include Types
      include Waiting

      class << self
        protected
          def banner(task, namespace = true, subcommand = false)
            if subcommand
              "#{basename} #{task.formatted_usage(self, true, subcommand)}"
            else
              super
            end
          end

          def default_credentials_file
            ENV["AWS_CREDENTIAL_FILE"] || File.expand_path("~/.aws-credentials")
          end
      end

      type DateTime => "date" do |switch|
      end

      class_option :debug, aliases: "-D", desc: "Enables debug mode", group: "Global", type: :boolean
      class_option :verbose, aliases: "-V", desc: "Enables verbose mode", group: "Global", type: :boolean

      class_option :access_key, aliases: "-A", banner: "KEY", desc: "Specify the AWS access key to use", group: "Credentials"
      class_option :secret_key, aliases: "-S", banner: "KEY", desc: "Specify the AWS secret key to use", group: "Credentials"
      class_option :credentials_file, aliases: "-C", banner: "FILE", default: default_credentials_file, desc: "Override the path to the credentials file", group: "Credentials"
      class_option :prompt_secret_key, desc: "Reads the secret key in from STDIN instead of as an argument", type: :boolean, group: "Credentials"

      map "-v" => "version"
      desc "version", "Prints the version of sam-aws"
      def version
        say "sam-aws #{AWS::VERSION}"
      end

      # no_tasks do
      #   def invoke_task(*)
      #     super
      #   rescue => e
      #     raise if options[:debug]
      #     $stderr.puts e
      #     exit 1
      #   end
      # end

      protected
        def access_key
          @access_key || (@access_key, @secret_key = get_credentials)[0]
        end

        def secret_key
          @secret_key || (@access_key, @secret_key = get_credentials)[1]
        end

        def account
          AWS::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def get_credentials
          if (access_key, secret_key = get_credentials_from_options).any?
            message = "You must provide you AWS %s with --%s."
            raise Error, message % ["access key", "access-key"] unless access_key
            raise Error, message % ["secret key", "secret-key"] unless secret_key
            return access_key, secret_key
          end

          if (access_key, secret_key = get_credentials_from_file(options[:credentials_file])).any?
            message = "Your credential file '#{options[:credentials_file]}' did not set %s."
            raise Error, message % "AWSAccessKeyId" unless access_key
            raise Error, message % "AWSSecretKey" unless secret_key
            return access_key, secret_key
          end

          if (access_key, secret_key = get_credentials_from_env).any?
            message = "You must set the %s environment variable."
            raise Error, message % "AWS_ACCESS_KEY" unless access_key
            raise Error, message % "AWS_SECRET_KEY" unless secret_key
            return access_key, secret_key
          end

          raise Error, "You must have a --credentials-file or specify your keys with --access-key and --secret-key."
        end

        def get_credentials_from_options
          # p options
          options.values_at(:access_key, :secret_key)
        end

        def get_credentials_from_file(file)
          if File.exists?(file)
            raise "'#{file}' exists but is not readable" unless File.readable?(file)

            access_key, secret_key = nil, nil

            File.read(file).lines do |line|
              access_key = $1 if line =~ /^AWSAccessKeyId=(.*)$/
              secret_key = $1 if line =~ /^AWSSecretKey=(.*)$/
            end

            [access_key, secret_key]
          end
        end

        def get_credentials_from_env
          [ENV["AWS_ACCESS_KEY"], ENV["AWS_SECRET_KEY"]]
        end

        def wait_until_available(what, method = :Status, available = "available")
          return unless options[:wait_until_available] and what.send(method) != available

          print "Waiting for #{method} to become #{available}"
          while what.send(method) != available
            sleep options[:wait_until_available_delay]
            print "."
            what = yield
          end
          puts " done!"
        end
    end
  end
end
