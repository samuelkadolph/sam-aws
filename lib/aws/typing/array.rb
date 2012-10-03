require "active_support/core_ext/class/attribute"

module AWS
  module Typing
    module ClassMethods
      def TypeArray(klass)
        Class.new(TypeArray) do
          self.klass = klass

          class << self
            def inspect
              "#{TypeArray}<#{klass}>"
            end

            def to_s
              "#{TypeArray}<#{klass}>"
            end
          end
        end
      end
    end

    class TypeArray < Array
      class_attribute :klass

      class << self
        alias default new
      end

      def new
        klass.default.tap do |object|
          self << object
        end
      end
    end
  end
end
