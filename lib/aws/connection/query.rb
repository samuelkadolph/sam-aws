module AWS
  require "aws/hash_sorting"

  class Connection
    class Query < Hash
      include HashSorting

      def initialize
        super
      end

      def add_option(name, option)
        self[name] = option if option
      end
    end
  end
end
