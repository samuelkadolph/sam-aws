require "aws"
require "proxifier/env"
require "thor"

module AWS
  module CLI
    class Base < Thor
      include Thor::Actions

      class << self
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

      method_option :debug, desc: "Enables debugging mode", aliases: %w(-d),
                            type: :boolean
      method_option :verbose, desc: "Enables verbose mode", aliases: %w(-v),
                              type: :boolean
      method_option :access_key, desc: "Specify the AWS access key to use", banner: "KEY"
      method_option :secret_key, desc: "Specify the AWS secret key to use", banner: "KEY"
      method_option :prompt_secret_key, desc: "Reads the secret key in from STDIN instead of as an argument", type: :boolean
      method_option :credentials_file, desc: "Override the path to the credentials file", banner: "FILE",
                                       type: :string, default: default_credentials_file
      def initialize(*)
        super
      end

      no_tasks do
        def invoke_task(*)
          super
        rescue => e
          raise if options[:debug]
          $stderr.puts e
          exit 1
        end
      end

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
            raise Thor::Error, message % ["access key", "access-key"] unless access_key
            raise Thor::Error, message % ["secret key", "secret-key"] unless secret_key
            return access_key, secret_key
          end

          if (access_key, secret_key = get_credentials_from_file(options[:credentials_file])).any?
            message = "Your credential file '#{options[:credentials_file]}' did not set %s."
            raise Thor::Error, message % "AWSAccessKeyId" unless access_key
            raise Thor::Error, message % "AWSSecretKey" unless secret_key
            return access_key, secret_key
          end

          if (access_key, secret_key = get_credentials_from_env).any?
            message = "You must set the %s environment variable."
            raise Thor::Error, message % "AWS_ACCESS_KEY" unless access_key
            raise Thor::Error, message % "AWS_SECRET_KEY" unless secret_key
            return access_key, secret_key
          end

          raise Thor::Error, "You must have a --credentials-file or specify your keys with --access-key and --secret-key."
        end

        def get_credentials_from_options
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
    end
  end
end
