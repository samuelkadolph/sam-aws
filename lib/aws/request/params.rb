module AWS
  require "aws/encoding"
  require "aws/hash_sorting"

  class Request
    class Params < Hash
      include Encoding::FormURL
      include Encoding::FormData
      include Encoding::URL
      include HashSorting

      def initialize(params = {})
        super()
        merge!(params) if params
      end

      def to_query_string
      end

      def to_body
      end
    end
  end
end
