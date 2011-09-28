module AWS
  class Account
    module Region
      def self.included(klass)
        klass.send(:include, Endpoint) unless klass.include?(Endpoint)
        klass.send(:option_reader, :region)
      end

      def initialize(options = {})
        super
        self.options[:endpoint] = endpoint % { region: region }
      end
    end
  end
end
