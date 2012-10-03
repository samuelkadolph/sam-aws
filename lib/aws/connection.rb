require "active_support/core_ext/hash/reverse_merge"
require "active_support/core_ext/module/attribute_accessors"
require "net/http"
require "net/http/persistent"
require "openssl"

module AWS
  require "aws/options"

  class Connection
    require "aws/connection/body"
    require "aws/connection/parameters"
    require "aws/connection/query"

    include Options

    DEFAULT_OPTIONS = {
      authenticator: Version2Authenticator,
      default_headers: {},
      default_query: {},
      expires_offset: 30,
      user_agent: "sam-aws/#{AWS::VERSION} (#{RUBY_DESCRIPTION}; OpenSSL/#{OpenSSL::VERSION})"
    }

    mattr_accessor :http
    self.http = Net::HTTP::Persistent.new("sam-aws")
    self.http.debug_output = $stderr
    self.http.ca_file = File.expand_path("../../../etc/certs/ca.pem", __FILE__)
    self.http.reuse_ssl_sessions = false unless defined?(OpenSSL::SSL::Session)

    attr_reader :account
    option_reader :authenticator, :default_headers, :default_query, :expires_offset, :user_agent

    def initialize(account, options = {})
      @account = account
      self.options = options
    end

    def auto(uri, parameters = {}, headers = {}, extra_types = [], &block)
      if block_given?
        extra = Parameters.new(extra_types)
        extra.instance_exec(extra, &block)
        parameters.merge!(extra)
      end
      request(:auto, uri, parameters, {}, nil, headers)
    end

    def delete(uri, query = {}, headers = {}, &block)
      query_method(:delete, uri, query, headers, &block)
    end

    def get(uri, query = {}, headers = {}, &block)
      query_method(:get, uri, query, headers, &block)
    end

    def post(uri, body = nil, headers = {}, &block)
      body_method(:post, uri, body, headers, &block)
    end

    protected
    def parse(response)
      case response["Content-Type"]
      when %r[\A(?:text|application)/xml]
        parser = Response::Parser.new(response)
        parser.parse(response.body)
        parser.response
      else
        raise Error, "unacceptable content type from server"
      end
    end

    def perform(request)
      request.clone.tap do |request|
        request.headers["Accept"] ||= "text/xml;application/xml"
        request.headers["User-Agent"] ||= user_agent
        request.headers.reverse_merge!(default_headers)
        request.query.reverse_merge!(default_query)

        request = authenticator.new(account).sign(request, expires: DateTime.now + expires_offset, time: DateTime.now)
        request.perform(http) do |response|
          return parse(response)
        end
      end
    end

    def request(method, uri, parameters = {}, query = {}, body = nil, headers = {})
      perform(Request.new(method, uri, parameters, query, body, headers).wrapper)
    end

    private
    def body_method(method, uri, body, headers, &block)
      if block_given?
        body = Body.new
        body.instance_exec(body, &block)
        headers["Content-Type"] = body.type
      end
      request(method, uri, nil, nil, body, headers)
    end

    def query_method(method, uri, query = {}, headers = {}, &block)
      if block_given?
        extra = Query.new
        extra.instance_exec(extra, &block)
        query.merge!(extra)
      end
      request(method, uri, {}, query, nil, headers)
    end
  end
end
