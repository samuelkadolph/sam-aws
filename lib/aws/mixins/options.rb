module AWS
  module Mixins
    module Options
      private
        def option_reader(*names)
          names.each { |name| class_eval "def #{name}; options[:#{name}]; end", __FILE__, __LINE__ }
        end

        def option_writter(*names)
          names.each { |name| class_eval "def #{name}=(value); options[:#{name}] = value; end", __FILE__, __LINE__ }
        end

        def option_accessor(*names)
          option_reader(*names)
          option_writter(*names)
        end
    end
  end
end
