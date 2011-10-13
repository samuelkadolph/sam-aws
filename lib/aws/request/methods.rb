require "net/http"

module AWS
  class Request
    @@methods = {}

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
    @@methods[:delete] = DeleteMethod

    class GetMethod < Method
      KLASS = Net::HTTP::Get
      VALUE = :get
    end
    @@methods[:get] = GetMethod

    class PostMethod < Method
      KLASS = Net::HTTP::Post
      VALUE = :post
    end
    @@methods[:post] = PostMethod

    class PutMethod < Method
      KLASS = Net::HTTP::Put
      VALUE = :put
    end
    @@methods[:put] = PutMethod
  end
end
