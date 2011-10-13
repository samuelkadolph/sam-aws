require "active_support/concern"

module AWS
  class Account
    require "aws/account/endpoint"

    module Region
      extend ActiveSupport::Concern

      include Endpoint

      included do
        option_reader :region
      end

      def initialize(options = {})
        super
        self.options[:endpoint] = endpoint % { region: region }
      end
    end
  end
end
