require "active_support/concern"
require "active_support/core_ext/class/attribute"

module AWS
  require "aws/bang"

  class Account
    module Auto
      extend ActiveSupport::Concern

      include Bang

      included do
        class_attribute :auto_types
        self.auto_types = []

        bang :auto
      end

      private
        # def auto(uri, params = {}, headers = {}, &block)
        #   connection_pool.checkout(uri) { |connection| connection.auto(uri, params, headers, auto_types, &block) }
        # end

        def auto(uri, params = {}, headers = {}, &block)
          connection.auto(uri, params, headers, auto_types, &block)
        end

      module ClassMethods
        private
        def auto(options = {})
          self.auto_types += Array(options[:add]) if options.key?(:add)
          self.auto_types
        end
      end
    end
  end
end
