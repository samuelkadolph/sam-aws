require "active_support/core_ext/module/delegation"
require "nokogiri"

module AWS
  class Connection
    class Body
      attr_accessor :type, :value

      delegate :bytesize, :dump, :length, :to_str, :to => :value

      def initialize
        self.value = ""
      end

      def xml(&block)
        self.type = %Q{text/xml; charset="UTF-8"}
        self.value = Nokogiri::XML::Builder.new(encoding: "UTF-8", &block).to_xml
      end
    end
  end
end
