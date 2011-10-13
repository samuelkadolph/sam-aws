module SES
  require "ses/params_content"

  class Account < AWS::Account
    include AWS::Account::Endpoint
    include AWS::Account::Region
    include AWS::Account::VersionInQuery

    DEFAULT_OPTIONS = {
      authenticator: AWS::AWS3HTTPSAuthenticator,
      endpoint: "https://email.%{region}.amazonaws.com",
      region: "us-east-1"
    }
    VERSION = "2010-12-01"

    def delete_verified_email_address(address, options = {})
      auto "Action" => "DeleteVerifiedEmailAddress", "EmailAddress" => address
    end
    bang :delete_verified_email_address

    def get_send_quota(options = {})
      auto "Action" => "GetSendQuota"
    end
    bang :get_send_quota

    def get_send_statistics(options = {})
      auto "Action" => "GetSendStatistics"
    end
    bang :get_send_statistics

    def list_verified_email_addresses(options = {})
      auto "Action" => "ListVerifiedEmailAddresses"
    end
    bang :list_verified_email_addresses

    def send_email(source, subject, body, options = {})
      auto "Action" => "SendEmail" do
        extend ParamsContent

        array["Destination.BccAddresses"] = options[:bcc]
        array["Destination.CcAddresses"] = options[:cc]
        array["Destination.ToAddresses"] = options[:to]
        content["Message.Body.Html"] = options[:html]
        content["Message.Body.Text"] = body
        content["Message.Subject"] = subject
        array["ReplyToAddresses"] = options[:reply_to]
        option["ReturnPath"] = options[:return_path]
        option["Source"] = source
      end
    end
    bang :send_email

    def send_raw_email(message, options = {})
      auto "Action" => "SendRawEmail", "RawMessage.Data" => message do
        array["Destinations"] = options[:destinations]
        option["Source"] = options[:source]
      end
    end
    bang :send_raw_email

    def verify_email_address(address, options = {})
      auto "Action" => "VerifyEmailAddress", "EmailAddress" => address
    end
    bang :verify_email_address
  end
end
