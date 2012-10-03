require "active_support/concern"
require "active_support/core_ext/class/attribute"
require "active_support/core_ext/object/inclusion"
require "date"

module AWS
  module Typing
    require "aws/typing/array"
    require "aws/typing/boolean"
    require "aws/typing/conversion"
    require "aws/typing/hash"

    extend ActiveSupport::Concern

    include Conversion

    included do
      class_attribute :properties
      self.properties = {}
    end

    module ClassMethods
      def default
        new
      end

      def inspect
        "#{self}(#{properties_for_inspect})"
      end

      protected
      def properties_for_inspect
        properties.map { |name, klass| "#{name}: #{klass}" }.join(", ")
      end

      private
      def array(name, klass = String)
        define_property(name, TypeArray(klass))
      end

      def field(name, klass = String)
        define_property(name, klass)
      end

      def define_property(name, klass)
        name = name.to_s.underscore
        self.properties = self.properties.merge(name => klass)
        define_method(name) do
          self[name]
        end
        define_method("#{name}=") do |value|
          self[name] = value
        end
        define_method("#{name}?") do
          !!self[name]
        end if klass == Boolean
      end

      def hash(name, klass = String)
        define_property(name, TypeHash(klass))
      end
    end

    def initialize(*)
      initialize_properties
      super
    end

    def [](key)
      raise IndexError, "unknown property #{key} for #{self.class}" unless properties.key?(key)
      properties[key]
    end

    def []=(key, value)
      raise IndexError, "unknown property #{key} for #{self.class}" unless properties.key?(key)
      properties[key] = convert(key, value)
    end

    def inspect
      "#<#{self.class}#{properties_for_inspect}>"
    end

    protected
    def convert(key, value)
      case what = self.class.properties[key]
      when Class
        if what <= Boolean
          Boolean(value)
        elsif what <= DateTime
          DateTime.parse(value)
        elsif what <= Float
          Float(value)
        elsif what <= Integer
          Integer(value)
        else
          value
        end
      when Array
        raise ArgumentError, "" unless value.in?(what)
        value
      else
        value
      end
    end

    def initialize_properties
      self.properties = Hash[self.class.properties.map { |name, klass| [name, klass.respond_to?(:default) ? klass.default : nil] }]
    end

    def properties_for_inspect
      " " << properties.map { |name, value| "#{name}: #{value.inspect}" }.join(", ") unless properties.empty?
    end
  end
end