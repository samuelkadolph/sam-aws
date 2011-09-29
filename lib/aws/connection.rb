require "net/http"
require "net/http/persistent"
require "openssl"
require "rbconfig"

module AWS
  require "aws/mixins/options"

  class Connection
    extend Mixins::Options

    DEFAULT_OPTIONS = {
      authenticator: Authenticator,
      default_headers: {},
      default_query: {},
      expires_offset: 30,
      user_agent: "sam-aws/#{AWS::VERSION} (#{RbConfig::CONFIG["host"]}; ruby/#{RUBY_VERSION}; OpenSSL/#{OpenSSL::VERSION})"
    }

    attr_reader :account, :options
    option_reader :authenticator, :default_headers, :default_query, :expires_offset, :user_agent

    def initialize(account, options = {}, defaults = DEFAULT_OPTIONS)
      @account, @options = account, defaults.merge(options)
    end

    def get(uri, query = {}, headers = {})
      request(:get, uri, nil, query)
    end

    def post(uri, data = nil, query = {}, headers = {})
      request(:post, uri, data, query)
    end

    protected
      def perform(request)
        @http ||= Net::HTTP::Persistent.new("sam-aws")

        request.clone.tap do |request|
          request.headers["Accept"] ||= "application/xml"
          request.headers["User-Agent"] ||= user_agent

          @http.connection_for(request.uri).request_get(request.uri.request_uri, request.headers) do |http_response|
            Response::Parser.new(http_response) do |parser|
              http_response.read_body { |part| parser << part }
              parser.finish
              return parser.response
            end
          end
        end
      end

      def request(method, uri, data = nil, query = {}, headers = {})
        request = Request.new(uri, method, headers)
        request.query.merge!(default_query).merge!(query)
        request = authenticator.new(account, request).request_with_signature(Time.now + expires_offset)
        perform(request)
      end
  end
end
