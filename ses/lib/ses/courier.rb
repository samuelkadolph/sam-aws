require "aws/options"
require "base64"

module SES
  class Courier
    include AWS::Options

    option_reader :access_key, :secret_key

    def initialize(options = {})
      self.options = options
    end

    def account
      @account ||= SES::Account.new(options)
    end

    def deliver(mail)
      account.send_raw_email!(Base64.encode64(mail.to_s))
    end
    alias deliver! deliver
  end
end


