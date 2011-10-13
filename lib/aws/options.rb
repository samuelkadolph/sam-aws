require "active_support/concern"

module AWS
  module Options
    extend ActiveSupport::Concern

    attr_accessor :options
    private :options=

    module ClassMethods
      private
        def option_reader(*names)
          names.each { |name| class_eval("def #{name}; options[:#{name}]; end", __FILE__, __LINE__) }
        end

        def option_writer(*names)
          names.each { |name| class_eval("def #{name}=(value); options[:#{name}] = value; end", __FILE__, __LINE__) }
        end

        def option_accessor(*names)
          option_reader(*names)
          option_writer(*names)
        end
    end
  end
end
