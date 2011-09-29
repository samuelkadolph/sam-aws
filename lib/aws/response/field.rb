module AWS
  class Response
    class << self
      def Field(*args)
        Field.new(*args)
      end
    end

    class Field
      attr_reader :default

      def initialize(default)
        @default = default
      end

      def new
        default ? default.dup : nil
      end
    end
  end
end
