module AWS
  class Account
    module Endpoint
      def self.included(klass)
        klass.send(:option_reader, :endpoint)
      end

      def initialize(options = {})
        super
        raise ArgumentError, ":endpoint must be set" unless endpoint
      end

      private
        def get(*args)
          super(endpoint, *args)
        end

        def post(*args)
          super(endpoint, *args)
        end
    end
  end
end
