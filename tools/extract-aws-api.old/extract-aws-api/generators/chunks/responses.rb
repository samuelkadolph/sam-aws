module Generators
  module Chunks
    class ResponseClass < ActionBase
      contents do
        line %Q{class #{name}Response < Response}
        line 2, body if body?
        line %Q{end}
      end

      def body
        unless api.data_type_for(API::Type.new(response.wrapper))
          raise "no DataTyp for wrapper"
        end

        contents do
          line %Q{field :#{response.wrapper}, #{response.wrapper}}
        end
      end

      def body?
        response? and response.wrapper?
      end
    end
  end
end
