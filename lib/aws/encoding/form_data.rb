require "active_support/concern"

module AWS
  module Encoding
    module FormData
      extend ActiveSupport::Concern

      def to_form_data_encoded
      end
    end
  end
end
