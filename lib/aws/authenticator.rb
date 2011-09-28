require "base64"
require "openssl"
require "time"

module AWS
  class Authenticator
    attr_reader :account, :request

    def initialize(account, request)
      @account, @request = account, request
    end

    def request_with_signature(expires = Time.now + 30)
      request.clone.tap do |request|
        request.query["AWSAccessKeyId"] = account.access_key
        request.query["Expires"] = expires.utc.iso8601
        request.query["SignatureMethod"] = "HmacSHA256"
        request.query["SignatureVersion"] = 2
        request.query.sort!

        data = "" << request.method << "\n" << request.host << "\n" << request.path << "\n" << request.query
        request.query["Signature"] = Base64.encode64(OpenSSL::HMAC.digest("SHA256", account.secret_key, data)).chomp
      end
    end
  end
end
