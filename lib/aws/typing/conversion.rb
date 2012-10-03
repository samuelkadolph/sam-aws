require "active_support/concern"

module AWS
  module Typing
    module Conversion
      extend ActiveSupport::Concern

      def to_parameters
        # TODO handle recursion?
        Hash[properties.map { |name, value| [name, value.to_s] }]
      end
    end
  end
end
