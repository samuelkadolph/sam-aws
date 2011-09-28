module AWS
  class Request
    class Headers < Hash
      def initialize(headers = {})
        super()
        merge!(headers)
      end
    end
  end
end
