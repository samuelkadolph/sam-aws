require "active_support/concern"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/core_ext/object/inclusion"

module AWS
  class Response
    module Properties
      extend ActiveSupport::Concern

      included do
        class_attribute :properties, instance_reader: false, instance_writer: false
        self.properties = {}

        mattr_accessor :stack, instance_reader: false, instance_writer: false
        # private :stack, :stack=
        self.stack = []
      end

      module ClassMethods
        private
          def properties_for_inspect
            properties.map { |name, type| "#{name}: #{type.inspect}" }.join(", ")
          end

          def array(name, *args, &block)
            if block_given?
              array = StructArray(name, build_struct(name, [], &block), args)
            else
              type, aliases = normalize_args(args)
              array = ValueArray(name, type, aliases)
            end

            build_property(name, array)
          end

          def field(name, *args)
            type, aliases = normalize_args(args)
            build_property(name, Field(name, type, aliases))
          end

          def method(name, *aliases, &block)
            build_property(name, Method(name, block, aliases))
          end

          def struct(name, *aliases, &block)
            aliases << :result if name =~ /_result\Z/ and not :result.in?(aliases)
            build_property(name, build_struct(name, aliases, &block))
          end

          def build_struct(name, aliases)
            self.stack.push({})
            yield
            Struct(name, self.stack.pop, aliases)
          end

          def build_property(name, type)
            if stack.empty?
              self.properties = self.properties.merge(name => type)
              type.define_methods(self)
            else
              stack.last[name] = type
            end
          end

          def normalize_args(args)
            case args.last
            when Class, :boolean
              type = args.pop
            else
              type = nil
            end

            [type, args]
          end
      end

      def initialize
        build_properties
      end

      def properties
        @properties ||= {}
      end

      def [](name)
        properties[name]
      end

      def []=(name, value)
        properties[name] = value
      end

      protected
        def properties_for_inspect
          properties.map { |name, value| "#{name}: #{value.inspect}" }.join(", ")
        end

      private
        def build_properties
          @properties = Hash[self.class.properties.map { |name, type| [name, type.new] }]
        end

      # private
      #   @@stack = []
      #   def struct(name, *aliases, &block)
      #     build_property(name, aliases, build_struct(name, &block))
      #   end
      #
      #   def array(name, *aliases, &block)
      #     type = aliases.last.is_a?(Class) ? alises.pop : nil
      #
      #     if block_given?
      #       array = StructArray(build_struct(name, &block))
      #     else
      #       array = ValueArray(type)
      #     end
      #
      #     build_property(name, aliases, array)
      #   end
      #
      #   def field(name, *aliases)
      #     build_property(name, aliases, Field(type))
      #   end
      #
      #   def method(name, &block)
      #     build_property(name, [], Method(&block))
      #   end
      #
      #   def build_struct(name)
      #     @@stack << {}
      #     yield
      #     Struct(@@stack.pop)
      #   end
      #
      #   def build_property(name, aliases, type)
      #     if @@stack.empty?
      #       properties[name] = type
      #       type.define_response_methods(name, self, aliases)
      #     else
      #       @@stack.last[name] = type
      #     end
      #   end
    end
  end
end
