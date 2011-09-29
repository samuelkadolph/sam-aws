module AWS
  RESPONSES = {}
  ABSTRACT_RESPONSES = %W[AWS::Response AWS::MetadataResponse]

  class Response
    require "aws/response/arrays"
    require "aws/response/field"
    require "aws/response/metadata"
    require "aws/response/parser"
    require "aws/response/properties"
    require "aws/response/struct"

    extend Properties

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
    end

    attr_reader :http_response

    def initialize(http_response)
      @http_response, @properties = http_response, {}
    end

    def inspect
      "#<#{self.class}#{properties_for_inspect}>"
    end

    def [](key)
      @properties[key]
    end

    def []=(key, value)
      @properties[key] = value
    end

    def error?
      http_response.code =~ /\A[45]/
    end

    def error
      Error.new("TODO")
    end

    def error!
      raise error
    end

    def informational?
      http_response.code =~ /\A1/
    end
    alias info? informational?

    def properties
      self.class.properties
    end

    def redirect?
      http_response.code =~ /\A3/
    end
    alias redirection? redirect?

    def success?
      http_response.code =~ /\A2/
    end
    alias successful? success?

    protected
      def properties_for_inspect
        " properties: " << self.properties.keys.join(", ") unless self.properties.empty?
      end
  end

  class MetadataResponse < Response
    include Response::Metadata
  end

  class ErrorResponse < Response
    struct "Error" do
      field "Type"
      field "Code"
      field "Message"
    end
    field "RequestId"

    def error?
      true
    end

    def error
      Error.new("#{self.Error.Code}: #{self.Error.Message}")
    end
  end
end
