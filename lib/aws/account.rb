module AWS
  require "aws/bang"
  require "aws/options"

  class Account
    require "aws/account/all"
    require "aws/account/auto"
    require "aws/account/endpoint"
    require "aws/account/region"
    require "aws/account/versioning"

    include All
    include Auto
    include Bang
    include Options

    option_reader :access_key, :secret_key
    filter_option :secret_key

    def initialize(options = {})
      super()
      self.options = options
      raise ArgumentError, "access_key must be set" unless access_key
      raise ArgumentError, "secret_key must be set" unless secret_key
    end

    def inspect
      "<#{self.class}#{options_for_inspect}>"
    end

    private
    def connection
      @connection ||= Connection.new(self, options)
    end

    # def connection_pool
    #   @connection_pool ||= CoonectionPool.new(self, options)
    # end
    #
    # def delete(uri, *args, &block)
    #   connection_pool.checkout(uri) { |connection| connection.delete(uri, *args, &block) }
    # end

    def delete(*args, &block)
      connection.delete(*args, &block)
    end
    bang :delete

    def get(*args, &block)
      connection.get(*args, &block)
    end
    bang :get

    def post(*args, &block)
      connection.post(*args, &block)
    end
    bang :post
  end
end

module IAM
  class Account < AWS::Account
    include Endpoint
    include VersionInQuery

    DEFAULT_OPTIONS = {
      endpoint: "https://iam.amazonaws.com"
    }
    VERSION = "2010-05-08"

    def account_id
      @account_id ||= begin
        result = auto!("/", "Action" => "GetUser").get_user_result
        result.user.user_id
      end
    end
  end
end

