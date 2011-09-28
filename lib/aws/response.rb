module AWS
  RESPONSES = {}
  ABSTRACT_RESPONSES = %W[AWS::Response AWS::MetadataResponse]

  class Response
    require "aws/response/arrays"
    require "aws/response/metadata"
    require "aws/response/parser"
    require "aws/response/struct"

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

      def properties
        @properties ||= self < Response ? superclass.properties.dup : []
      end

      private
        @@stack = []
        def struct(name, &block)
          build_property(name, build_struct(name, &block))
        end

        def array(name, &block)
          if block_given?
            array = StructArray(build_struct(name, &block))
          else
            array = ValueArray()
          end

          build_property(name, array)
        end

        def field(name)
          build_property(name)
        end

        def build_struct(name)
          @@stack << {}
          yield
          Struct.new(@@stack.pop)
        end

        def build_property(name, type = NilClass)
          if @@stack.empty?
            define_method(name) do
              self[name] ||= type.new
            end
            properties << name
          else
            @@stack.last[name] = type
          end
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
      RuntimeError.new("TODO")
    end

    def error!
      raise error
    end

    def informational?
      http_response.code =~ /\A1/
    end
    alias info? informational?

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
        " properties: " << self.class.properties.join(", ") unless self.class.properties.empty?
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
      RuntimeError.new("#{self.Error.Code}: #{self.Error.Message}")
    end
  end
end

class Blah < AWS::Response
  struct "a" do
    array "b"
    array "c" do
      field "d"
    end
  end
end

