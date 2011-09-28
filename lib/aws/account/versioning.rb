module AWS
  class Account
    module Versioning
      def connection
        super.tap do |connection|
          connection.default_query["Version"] = self.class::VERSION
        end
      end
    end
  end
end
