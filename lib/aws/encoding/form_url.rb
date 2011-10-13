require "active_support/concern"

module AWS
  module Encoding
    require "aws/encoding/url"

    module FormURL
      extend ActiveSupport::Concern

      include URL

      def to_form_url_encoded
        # replace with own method?
        to_url_encoded.gsub("%20", "+")
      end
    end
  end
end
