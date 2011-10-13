require "active_support/concern"

module AWS
  class Account
    module Bang
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def bang(symbol)
            class_eval <<-RUBY, __FILE__, __LINE__ + 1
              def #{symbol}!(*args)
                bang #{symbol}(*args)
              end
            RUBY
          end
      end
    end
  end
end
