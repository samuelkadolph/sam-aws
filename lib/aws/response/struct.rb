module AWS
  class Response
    class << self
      def Struct(*args)
        Struct.new(*args)
      end
    end

    class Struct < ::Struct
      class << self
        attr_accessor :properties

        def new(properties)
          super(nil, *properties.keys).tap do |struct|
            struct.properties = properties
          end
        end
      end

      def initialize
        super(*self.class.properties.values.map(&:new))
      end
    end
  end
end
