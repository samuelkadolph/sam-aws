require "active_support/concern"
require "active_support/core_ext/class/attribute"
require "time"

module AWS
  class Response
    module Types
      extend ActiveSupport::Concern

      module ClassMethods
        def Field(name, type, aliases = [])
          Class.new(Field) do |field|
            field.aliases = aliases
            field.name = name
            field.type = type
          end
        end

        def Method(name, block, aliases = [])
          Class.new(Method) do |method|
            method.aliases = aliases
            method.name = name
            method.block = block
          end
        end

        def Struct(name, properties, aliases = [])
          Struct.new(nil, *properties.keys) do |struct|
            struct.aliases = aliases
            struct.name = name
            struct.properties = properties
          end
        end

        def StructArray(name, struct, aliases = [])
          Class.new(StructArray) do |array|
            array.aliases = aliases
            array.name = name
            array.struct = struct
          end
        end

        def ValueArray(name, type, aliases = [])
          Class.new(ValueArray) do |array|
            array.aliases = aliases
            array.name = name
            array.type = type
          end
        end
      end

      module Type
        extend ActiveSupport::Concern

        included do
          class_attribute :aliases
          class_attribute :name
        end

        module ClassMethods
          def define_methods(reciever)
            type = self
            reciever.class_eval do
              define_method(type.name) do
                self[type.name] ||= type.new
              end

              define_method("#{type.name}=") do |value|
                self[type.name] = type.respond_to?(:convert) ? type.convert(value) : value
              end

              type.aliases.each { |aliaz| alias_method(aliaz, type.name) }
            end
          end
        end
      end

      module ConvertableType
        extend ActiveSupport::Concern

        included do
          class_attribute :type
          extend ConvertableType
        end

        def convert(value)
          case type
          when Class
            if type <= DateTime
              Time.parse(value)
            elsif type <= Float
              Float(value)
            elsif type <= Integer
              Integer(value)
            else
              value
            end
          when :boolean
            if value == "true"
              true
            else
              false
            end
          when Array
            value
          else
            value
          end
        end
      end

      class Field
        include Type
        include ConvertableType

        class << self
          def default
            nil
          end
          alias new default

          def define_methods(reciever)
            super

            field = self
            reciever.class_eval do
              define_method("#{field.name}?") { !!send(filed.name) } if field.type == :boolean
            end
          end

          def inspect
            "#<Field:#{type}>"
          end
        end
      end

      class Method
        include Type
        class_attribute :block

        class << self
          def define_methods(reciever)
            method = self
            reciever.class_eval do
              define_method(method.name, &method.block)
              method.type.aliases.each { |aliaz| alias_method(aliaz, method.name) }
            end
          end
        end
      end

      class Struct < ::Struct
        include Type
        class_attribute :properties

        def initialize
          super

          properties.each do |name, type|
            type.define_methods(singleton_class)
          end
        end
      end

      class StructArray < ::Array
        include Type
        class_attribute :struct

        class << self
          def inspect
            "#<StructArray:#{struct.inspect}>"
          end
        end

        def add
          struct.new.tap do |struct|
            self << struct
          end
        end
      end

      class ValueArray < ::Array
        include Type
        include ConvertableType
        class_attribute :type

        class << self
          def inspect
            "#<ValueArray:#{type}>"
          end
        end

        def <<(object)
          super(convert(object))
        end
      end
    end
  end
end
