module AWS
  require "aws/encoding/url"
  require "aws/hash_sorting"

  class Request
    class Query < Hash
      include Encoding::URL
      include HashSorting

      def initialize(query_string = nil)
        super()

        query_string.split("&").each do |part|
          key, value = part.split("=", 2).map(&method(:url_decode))
          self[key] = value
        end if query_string
      end

      alias to_query_string to_url_encoded
      alias to_s   to_query_string
      alias to_str to_query_string
    end
  end
end
