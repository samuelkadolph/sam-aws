module AWS
  class Response
    class << self
      def StructArray(struct)
        Class.new(StructArray).tap do |klass|
          klass.struct = struct
        end
      end

      def ValueArray(type)
        Class.new(ValueArray).tap do |klass|
          klass.type = type
        end
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
      class << self
        attr_accessor :type
      end

      # TODO: handle type forcing
    end
  end
end
