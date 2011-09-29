module AWS
  module Mixins
    module Bang
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
