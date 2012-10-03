require "aws/cli/base"
require "base64"
require "ses"

module SES
  module CLI
    class Main < AWS::CLI::Base
      namespace "ses"

      desc "delete-verified-email-address ADDRESS", "Deletes a verified email address"
      def delete_verified_email_address(address)
        account.delete_verified_email_address!(address, options)
      end

      table_method_options
      desc "get-send-quota", "Prints current sending limits"
      def get_send_quota
        result = account.get_send_quota!(options).result
        tableize_send_quota_result(result).print
      end

      table_method_options
      desc "get-send-statistics", "Pints sending statistics over the last two weeks"
      def get_send_statistics
        result = account.get_send_statistics!(options).result
        tableize_send_data_point(result.points).print
      end

      desc "list-verified-email-addresses", "Lists verified email addresses"
      def list_verified_email_addresses
        result = account.list_verified_email_addresses!(options).result
        puts result.addresses
      end

      desc "send-email SOURCE SUBJECT BODY", "Sends an email"
      method_option :bcc, aliases: "-b", banner: "EMAIL [EMAIL...]", type: :array
      method_option :cc, aliases: "-c", banner: "EMAIL [EMAIL...]", type: :array
      method_option :html, aliases: "-h", banner: "HTML"
      method_option :reply_to, aliases: "-r", banner: "EMAIL"
      method_option :return_path, aliases: "-R", banner: "EMAIL"
      method_option :to, aliases: "-t", banner: "EMAIL [EMAIL...]", required: true, type: :array
      def send_email(source, subject, body)
        account.send_email!(source, subject, body, options)
      end

      desc "send-raw-email [RAW|FILE]", "Sends a raw email (will read from stdin if no argument is given)"
      method_option :destinations, aliases: "-D", banner: "EMAIL [EMAIL...]", type: :array,
                    desc: "Overrides the destinations of the email"
      method_option :source, aliases: "-S", banner: "EMAIL", desc: "Overrides the source of the email"
      def send_raw_email(mail = nil)
        if mail == nil
          raw = $stdin.read
        elsif File.exists?(path = File.expand_path(mail))
          raw = File.read(path)
        else
          raw = mail
        end

        account.send_raw_email!(Base64.encode64(raw), options)
      end

      desc "verify-email-address ADDRESS", "Verifies an email address"
      def verify_email_address(address)
        account.verify_email_address!(address, options)
      end

      protected
        def account
          SES::Account.new(access_key: access_key, secret_key: secret_key)
        end

      private
        def tableize_send_quota_result(result)
          table do
            header "max24_hour_send", "max_send_rate", "sent_last24_hours"
            row result.max24_hour_send, result.max_send_rate, result.sent_last24_hours
          end
        end

        def tableize_send_data_point(points)
          table do
            header "bounces", "complaints", "delivery_attempts", "rejects", "timestamp"

            points.each do |p|
              row p.bounces, p.complaints, p.delivery_attempts, p.rejects, p.timestamp
            end
          end
        end
    end
  end
end
