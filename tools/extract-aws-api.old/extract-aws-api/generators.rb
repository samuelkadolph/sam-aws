require "active_support/core_ext/class/attribute"
require "active_support/core_ext/module/delegation"
require "helpers"

module Generators
  class Base
    class_attribute :block
    class << self
      def contents(&block)
        self.block = block
      end
    end

    def to_s
      lines
    end

    private
      def contents(&block)
        stack.push(lines = [])
        instance_exec(&block)
        lines.join("\n") << "\n"
      ensure
        stack.pop
      end

      def line(*args)
        indent = args.shift if args.first.is_a?(Integer)

        str = ""
        args.each do |arg|
          case arg
          when Array
            str << arg.join("\n")
          else
            str << arg.to_s
          end
        end

        str.chomp!
        str.indent!(indent) if indent
        stack.last << str
      end

      def lines
        contents(&block)
      end

      def stack
        @stack ||= []
      end
  end

  class << self
    def Base(thing)
      attribute = thing.to_s.demodulize.underscore

      if thing.respond_to?(:instance_methods) #and thing.respond_to?(:ancesors)
        methods = thing.instance_methods - Object.instance_methods - Comparable.instance_methods - WebHelpers.instance_methods
        # methods = thing.instance_methods - thing.ancestors.map(&:instance_methods).flatten
      end

      Class.new(Base) do |klass|
        klass.class_eval do
          attr_accessor attribute
          delegate *methods, :to => attribute if methods

          define_method(:initialize) do |obj|
            send("#{attribute}=", obj)
          end
        end
      end
    end
  end

  class APIBase < Base(API)
  end

  class ActionBase < Base(API::Action)
  end

  class DataTypeBase < Base(API::DataType)
  end

  class ErrorBase < Base(API::Error)
  end

  class ParameterBase < Base(API::Parameter)
  end

  class TypesBase < Base("types")
  end

  require "generators/chunks"
  require "generators/files"
end
