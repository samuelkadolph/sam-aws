require "active_support/concern"

module AWS
  module Bang
    extend ActiveSupport::Concern

    private
    def bang(what)
      what.error! if what.error?
      what
    end

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
