module AWS
  class Response
    module Metadata
      def self.included(klass)
        klass.class_eval do
          struct "ResponseMetadata" do
            field "RequestId"
          end
        end
      end
    end
  end
end
