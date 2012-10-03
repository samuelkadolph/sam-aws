require "aws/bang"
require "base64"

module SES
  class Courier
    include AWS::Bang

    def initialize(options = {})
      @account = SES::Account.new(options)
    end

    def deliver(mail)
      @account.send_raw_email(Base64.encode64(mail.to_s))
    end
    bang :deliver

    def inspect
      "#<#{self.class} #{options_for_inspect}>"
    end
  end
end


