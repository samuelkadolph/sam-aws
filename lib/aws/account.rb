module AWS
  require "aws/mixins/bang"
  require "aws/mixins/options"

  class Account
    require "aws/account/endpoint"
    require "aws/account/region"
    require "aws/account/versioning"

    extend Mixins::Bang
    extend Mixins::Options

    DEFAULT_OPTIONS = {}

    attr_reader :options
    option_reader :access_key, :secret_key

    def initialize(options = {})
      @options = self.class::DEFAULT_OPTIONS.merge(options)
      raise ArgumentError, ":access_key must be set" unless access_key
      raise ArgumentError, ":secret_key must be set" unless secret_key
    end

    def inspect
      "<#{self.class}#{options_for_inspect}>"
    end

    protected
      def options_for_inspect
        " options: " << options.map do |key, value|
          value = filter_option(value) if key == :secret_key
          "#{key}: #{value.inspect}"
        end.join(", ")
      end

      def filter_option(option, masker = "*")
        case size = option.size
        when 0
          ""
        when 1..3
          "*" * size
        when 4..7
          "" << option[0] << masker * (size - 2) << option[-1]
        when 8..15
          "" << option[0...2] << masker * (size - 4) << option[-2..-1]
        else
          "" << option[0...4] << masker * (size - 8) << option[-4..-1]
        end
      end

    private
      def bang(response)
        response.error! if response.error?
        response
      end

      def connection
        @connection ||= Connection.new(self, options)
      end

      def get(*args)
        connection.get(*args)
      end

      def get!(*args)
        bang get(*args)
      end

      def post(*args)
        connection.post(*args)
      end

      def post!(*args)
        bang post(*args)
      end
  end
end
