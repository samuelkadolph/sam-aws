module AWS
  class Response
    class Struct < ::Struct
      class << self
        attr_accessor :values

        def new(properties)
          super(nil, *properties.keys).tap do |struct|
            struct.values = properties.values
          end
        end
      end

      def initialize
        super(*self.class.values.map(&:new))
       end
    end
  end
end
