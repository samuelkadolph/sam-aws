require "active_support/core_ext/class/attribute"

module AWS
  module Typing
    module ClassMethods
      def TypeHash(klass)
        Class.new(TypeHash) do
          self.klass = klass

          class << self
            def inspect
              "#{TypeHash}<#{klass}>"
            end

            def to_s
              "#{TypeHash}<#{klass}>"
            end
          end
        end
      end
    end

    class TypeHash < Hash
      class_attribute :klass

      class << self
        alias default new
      end

      def new(key)
        klass.default.tap do |object|
          self[key] = object
        end
      end
    end
  end
end
