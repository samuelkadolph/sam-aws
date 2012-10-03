require "active_support/concern"

module AWS
  require "aws/options"

  class Account
    require "aws/account/endpoint"

    module Region
      extend ActiveSupport::Concern

      include Options

      included do
        option_reader :region
      end

      def initialize(*)
        super
        options[:endpoint] = endpoint % { region: region } if respond_to?(:endpoint) && options.key?(:endpoint)
      end
    end
  end
end
