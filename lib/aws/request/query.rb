module AWS
  require "aws/mixins/url_encoding"

  class Request
    class Query < Hash
      include Mixins::URLEncoding

      def initialize(query_string = nil)
        super()

        query_string.split("&").each do |part|
          key, value = part.split("=", 2).map(&method(:url_decode))
          self[key] = value
        end if query_string
      end

      def sort
        dup.sort!
      end

      def sort!
        replace(Hash[sort_by { |k, v| k }])
      end

      def to_s
        map do |key, value|
          url_encode(key.to_s) << "=" << url_encode(value.to_s)
        end.join("&")
      end
      alias to_str to_s
    end
  end
end
