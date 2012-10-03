require "active_support/core_ext/class/attribute"

module AWS
  require "aws/sortable_hash"

  class Connection
    class Parameters < SortableHash
      class ScopeBase
        attr_reader :parent

        def initialize(parent)
          @parent = parent
        end

        def []=(key, sym)
          return unless value = value_for(sym)
          parent[key] = value
        end

        def array
          @array ||= ArrayScope.new(self)
        end

        def options
          parameters.options
        end

        def parameters
          parent.is_a?(Parameters) ? parent : parent.parameters
        end

        def required
          @required ||= RequiredScope.new(self)
        end

        private
        def value_for(sym_or_obj)
          if sym_or_obj.is_a?(Symbol)
            raise Error, "options must be set to use symbol assignments" unless options
            options[sym_or_obj]
          else
            sym_or_obj
          end
        end
      end

      class ArrayScope < ScopeBase
        def []=(key, sym)
          return unless value = value_for(sym)
          raise ArgumentError, "#{sym.inspect} must respond to each" unless value.respond_to?(:each)
          n = 1
          value.each do |object|
            parent["#{key}.member.#{n}"] = object
            n += 1
          end
        end
      end

      class BooleanScope < ScopeBase
        def []=(key, sym)
          return unless value = value_for(sym)
          parent[key] = value ? "true" : "false"
        end
      end

      class DateTimeScope < ScopeBase
        def []=(key, sym)
          return unless value = value_for(sym)
          parent[key] = value.utc.iso8601
        end
      end

      class ExtraTypeScope < ScopeBase
        attr_reader :type

        def initialize(parent, type)
          raise ArgumentError, "#{type.inspect} must respond to #to_parameters" unless type.method_defined?(:to_parameters)
          super(parent)
          @type = type
        end

        def []=(key, sym)
          return unless value = value_for(sym)
          value.to_parameters.each do |name, value|
            parent["#{key}.#{name}"] = value
          end
        end
      end

      class RequiredScope < ScopeBase
        def []=(key, sym)
          raise ArgumentError, "#{sym} must be provided" unless options.key?(sym)
          parent[key] = sym
        end
      end

      class StringScope < ScopeBase
        def []=(key, sym)
          return unless value = value_for(sym)
          parent[key] = value.to_s
        end
      end

      attr_accessor :options

      def initialize(extra_types = [])
        super()
        extra_types.each do |extra_type|
          class_eval do
            define_method(extra_type.name.demodulize.underscore) do
              ExtraTypeScope.new(self, extra_type)
            end
          end
        end if extra_types
      end

      def boolean
        @boolean ||= BooleanScope.new(self)
      end

      def date_time
        @date_time ||= DateTimeScope.new(self)
      end

      def integer
        @integer ||= IntegerScope.new(self)
      end

      def string
        @string ||= StringScope.new(self)
      end
    end
  end
end
