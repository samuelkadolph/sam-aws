require "active_support/core_ext/module/delegation"

module AWS
  RESPONSES = {}
  ABSTRACT_RESPONSES = %W[AWS::Response]

  class Response
    require "aws/response/parser"
    require "aws/response/properties"
    require "aws/response/types"

    include Properties
    include Types

    class << self
      def inherited(klass)
        AWS::RESPONSES[klass.response_name] = klass unless klass.abstract_response?
      end

      def response_name
        name.gsub(/^.*::/, "")
      end

      def abstract_response?
        ABSTRACT_RESPONSES.include?(name)
      end

      def inspect
        "#{self} (#{properties_for_inspect})"
      end
    end

    attr_reader :attributes, :http_response
    delegate :code, :message, :to => :http_response

    def initialize(http_response, attributes = [])
      @http_response, @attributes = http_response, attributes
      super()
    end

    def build_error
      Error.new("HTTP Error #{code} #{message}")
    end

    def error?
      code =~ /\A[45]/
    end

    def error!
      raise build_error
    end

    def informational?
      code =~ /\A1/
    end
    alias info? informational?

    def inspect
      "#<#{self.class} #{properties_for_inspect}>"
    end

    def redirect?
      code =~ /\A3/
    end
    alias redirection? redirect?

    def request_id
      self["x-amzn-RequestId"]
    end

    def success?
      code =~ /\A2/
    end
    alias successful? success?
  end
end
