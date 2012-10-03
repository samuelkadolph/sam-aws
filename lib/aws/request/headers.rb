module AWS
  require "aws/sortable_hash"

  class Request
    class Headers < SortableHash
      def initialize(headers = {})
        super()
        merge!(headers) if headers
      end
    end
  end
end
