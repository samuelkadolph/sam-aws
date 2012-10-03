require "active_support/core_ext/class/attribute"
require "net/http"

module AWS
  class Request
    class_attribute :methods
    self.methods = {}

    class Method
      def klass
        self.class::KLASS
      end

      def to_s
        self.class::VALUE.to_s.upcase
      end
      alias inspect to_s
      alias to_str  to_s
    end

    class DeleteMethod < Method
      KLASS = Net::HTTP::Delete
      VALUE = :delete
    end
    methods[DeleteMethod::VALUE] = DeleteMethod

    class GetMethod < Method
      KLASS = Net::HTTP::Get
      VALUE = :get
    end
    methods[GetMethod::VALUE] = GetMethod

    class PostMethod < Method
      KLASS = Net::HTTP::Post
      VALUE = :post
    end
    methods[PostMethod::VALUE] = PostMethod

    class PutMethod < Method
      KLASS = Net::HTTP::Put
      VALUE = :put
    end
    methods[PutMethod::VALUE] = PutMethod
  end
end
