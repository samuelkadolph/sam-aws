require "active_support/concern"

module AWS
  module Encoding
    module URL
      extend ActiveSupport::Concern

      # url_encode
      #
      # Properly encodes a url part according to RFC 3986.
      def url_encode(part)
        part.gsub(/([^a-zA-Z0-9._~-]+)/) do |chunk|
          chunk.unpack("H*").map { |h| "%#{h}" }.join.upcase
        end
      end
      module_function :url_encode

      # url_decode
      #
      # Properly decodes a url part according to RFC 3986.
      def url_decode(part)
        part.gsub(/((%[a-zA-Z0-9]{2})+)/) do |part|
          [part.delete("%")].pack("H*")
        end
      end
      module_function :url_decode

      def to_url_encoded
        map do |key, value|
          url_encode(key.to_s) << "=" << url_encode(value.to_s)
        end.join("&")
      end
    end
  end
end
