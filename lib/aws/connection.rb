require "active_support/core_ext/hash/reverse_merge"
require "net/http"
require "net/http/persistent"
require "openssl"

module AWS
  require "aws/options"

  class Connection
    require "aws/connection/body"
    require "aws/connection/params"
    require "aws/connection/query"

    include Options

    DEFAULT_OPTIONS = {
      authenticator: Version2Authenticator,
      default_headers: {},
      default_query: {},
      expires_offset: 30,
      user_agent: "sam-aws/#{AWS::VERSION} (#{RUBY_DESCRIPTION}; OpenSSL/#{OpenSSL::VERSION})"
    }

    attr_reader :account, :options
    option_reader :authenticator, :default_headers, :default_query, :expires_offset, :user_agent

    @@http = Net::HTTP::Persistent.new("sam-aws")
    @@http.debug_output = $stderr

    def initialize(account, options = {})
      @account, @options = account, self.class::DEFAULT_OPTIONS.merge(options)
    end

    def auto(uri, params = {}, headers = {}, &block)
      handle_action_block(params, Params, &block)
      request(:auto, uri, params, {}, nil, headers)
    end

    def delete(uri, query = {}, headers = {}, &block)
      handle_action_block(query, Query, &block)
      request(:delete, uri, {}, query, nil, headers)
    end

    def get(uri, query = {}, headers = {}, &block)
      handle_action_block(query, Query, &block)
      request(:get, uri, {}, query, nil, headers)
    end

    def post(uri, body = nil, headers = {})
      if block_given?
        body = Body.new
        body.instance_exec(body, &block)
        headers["Content-Type"] = body.type
      end
      request(:post, uri, nil, nil, body, headers)
    end

    protected
      def parse(response)
        case response["Content-Type"]
        when %r[\A(?:text|application)/xml]
          Response::Parser.new(response) do |parser|
            # puts response.body
            # parser << response.body
            response.read_body { |part| parser << part }
          end.response
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

          auth = authenticator.new(account, request)
          request = auth.sign(expires: Time.now + expires_offset, time: Time.now)

          request.perform(@@http) do |response|
            return parse(response)
          end
        end
      end

      def request(method, uri, params = {}, query = {}, body = nil, headers = {})
        request = Request.new(method, uri, params, query, body, headers).wrapper
        perform(request)
      end

    private
      def handle_action_block(hash, klass, &block)
        if block_given?
          extra = klass.new
          extra.instance_exec(extra, &block)
          hash.merge!(extra)
        end
      end
  end
end
