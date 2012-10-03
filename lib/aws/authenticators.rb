require "base64"
require "openssl"
require "date"
require "active_support/core_ext/date_time/calculations"

module AWS
  class Authenticator
    attr_reader :account

    def initialize(account)
      @account = account
    end

    def sign(request, options = {})
      raise NotImplementedError
    end
  end

  class Version1Authenticator < Authenticator
    def sign(request, options = {})
      raise Error, "version 1 signatures are unsecure and no longer supported"
    end
  end

  class Version2Authenticator < Authenticator
    def sign(request, options = {})
      options[:expires] ||= DateTime.now + 30

      request.clone.tap do |request|
        request.query["AWSAccessKeyId"] = account.access_key
        request.query["Expires"] = options[:expires].utc.iso8601
        request.query["SignatureMethod"] = "HmacSHA256"
        request.query["SignatureVersion"] = 2
        request.query.sort!
        request.query["Signature"] = signature(request)
      end
    end

    protected
    def signature(request)
      Base64.encode64(OpenSSL::HMAC.new(account.secret_key, "SHA256").tap do |hmac|
        hmac << request.method << "\n" << request.host << "\n" << request.path << "\n" << request.query
      end.digest).chomp
    end
  end

  class S3HTTPSAuthenticator < Authenticator
    def sign(request, options = {})
      options[:time] ||= DateTime.now

      request.clone.tap do |request|
        request.headers["Date"] = options[:time].utc.httpdate
        request.headers["X-Amzn-Authorization"] = authorization(request)
      end
    end

    protected
    def authorization(request)
      "AWS3-HTTPS AWSAccessKeyId=#{account.access_key}, Algorithm=HmacSHA256, Signature=#{signature(request)}"
    end

    def signature(request)
      Base64.encode64(OpenSSL::HMAC.new(account.secret_key, "SHA256").tap do |hmac|
        hmac << request.headers["Date"]
      end.digest).chomp
    end
  end
end
