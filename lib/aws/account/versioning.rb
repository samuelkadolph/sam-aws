require "active_support/concern"

module AWS
  class Account
    module VersionInPath
      extend ActiveSupport::Concern

      private
      def auto(uri, *args)   super(*add_version(uri, args)) end
      def delete(uri, *args) super(*add_version(uri, args)) end
      def get(uri, *args)    super(*add_version(uri, args)) end
      def post(uri, *args)   super(*add_version(uri, args)) end

      def add_version(uri, args)
        case uri
        when String
          uri = "/#{self.class::VERSION}/#{uri}"
        when URI
          uri.path = "/#{self.class::VERSION}/#{uri.path}"
        end

        [uri, *args]
      end
    end

    module VersionInQuery
      extend ActiveSupport::Concern

      def connection
        super.tap do |connection|
          connection.default_query["Version"] = self.class::VERSION
        end
      end
    end
  end
end
