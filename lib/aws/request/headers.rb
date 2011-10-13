module AWS
  require "aws/hash_sorting"

  class Request
    class Headers < Hash
      include HashSorting

      def initialize(headers = {})
        super()
        merge!(headers) if headers
      end
    end
  end
end
