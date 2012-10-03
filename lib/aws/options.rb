require "active_support/concern"
require "active_support/core_ext/class/attribute"

module AWS
  module Options
    extend ActiveSupport::Concern

    DEFAULT_OPTIONS = {}

    included do
      class_attribute :filtered_options, instance_writer: false
      self.filtered_options = []
    end

    def options
      @options ||= self.class::DEFAULT_OPTIONS.dup
    end

    protected
    def options_for_inspect
      " " << options.map { |name, value| "#{name}: #{filter_option(name, value).inspect}" }.join(", ") unless options.empty?
    end

    def filter_option(name, option, mask = "*")
      return option unless filtered_options.include?(name)
      case size = option.size
      when 0
        ""
      when 1..3
        mask * size
      when 4..7
        "" << option[0] << mask * (size - 2) << option[-1]
      when 8..15
        "" << option[0...2] << mask * (size - 4) << option[-2..-1]
      else
        "" << option[0...4] << mask * (size - 8) << option[-4..-1]
      end
    end

    private
    def options=(hash)
      @options = self.class::DEFAULT_OPTIONS.merge(hash)
    end

    module ClassMethods
      private
      def filter_options(*names)
        self.filtered_options += names
        nil
      end
      alias filter_option filter_options

      def option_reader(*names)
        names.each { |name| class_eval("def #{name}; options[:#{name}]; end", __FILE__, __LINE__) }
        nil
      end

      def option_writer(*names)
        names.each { |name| class_eval("def #{name}=(value); options[:#{name}] = value; end", __FILE__, __LINE__) }
        nil
      end

      def option_accessor(*names)
        option_reader(*names)
        option_writer(*names)
      end
    end
  end
end
