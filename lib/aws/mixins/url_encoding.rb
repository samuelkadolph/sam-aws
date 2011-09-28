module AWS
  module Mixins
    module URLEncoding
      # url_encode
      #
      # Properly encodes a url part according to RFC 3986.
      def url_encode(str)
        str.gsub(/([^a-zA-Z0-9._~-])/) do |part|
          part.unpack("H2" * part.size).map { |h| "%#{h}" }.join.upcase
        end
      end
      module_function :url_encode

      # url_decode
      #
      # Properly decodes a url part according to RFC 3986.
      def url_decode(str)
        str.gsub(/((%[a-zA-Z0-9]{2})+)/) do |part|
          [part.delete("%")].pack("H*")
        end
      end
    end
  end
end
