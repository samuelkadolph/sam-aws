require "active_support/concern"

module AWS
  require "aws/options"

  class Account
    module Endpoint
      extend ActiveSupport::Concern

      include Options

      included do
        option_reader :endpoint
      end

      def initialize(*)
        super
        raise ArgumentError, "endpoint must be set" unless endpoint
      end

      private
      def auto(*args)   super(*add_endpoint(args)) end
      def delete(*args) super(*add_endpoint(args)) end
      def get(*args)    super(*add_endpoint(args)) end
      def post(*args)   super(*add_endpoint(args)) end

      def add_endpoint(args)
        uri = URI(endpoint)
        uri += args.shift if args.first.is_a?(String) || args.first.is_a?(URI)
        [uri, *args]
      end
    end
  end
end
