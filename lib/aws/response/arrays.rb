module AWS
  class Response
    class << self
      def StructArray(struct)
        Class.new(StructArray).tap do |klass|
          klass.struct = struct
        end
      end

      def ValueArray
        Class.new(ValueArray)
      end
    end

    class StructArray < ::Array
      class << self
        attr_accessor :struct
      end

      def new
        self.class.struct.new.tap do |struct|
          self << struct
        end
      end
    end

    class ValueArray < ::Array
    end

    # class Array
    #   class << self
    #     def new(struct)
    #       klass = Class.new(::Array)
    #       klass.class_eval do
    #         def initialize
    #           super
    #         end
    #
    #         if struct
    #           define_method(:new) do
    #             struct.new.tap do |struct|
    #               self << struct
    #             end
    #           end
    #         else
    #           define_method(:member=) do |value|
    #             self << value
    #           end
    #         end
    #       end
    #       klass
    #     end
    #   end
    # end
  end
end
