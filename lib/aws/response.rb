require "active_support/core_ext/class/attribute"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/object/inclusion"
require "active_support/core_ext/string/inflections"

module AWS
  class Response
    require "aws/response/parser"
    require "aws/typing"

    include Typing

    class_attribute :abstract_responses, :responses, instance_reader: false, instance_writer: false
    self.abstract_responses = [/::Response$/]
    self.responses = {}

    class << self
      def abstract_response?
        abstract_responses.any? { |r| r === name }
      end

      def inherited(klass)
        responses[klass.response_name] = klass unless klass.abstract_response?
      end

      def response_name
        name.demodulize
      end

      private
      def field(name, *rest)
        name = name.to_s
        super(name, *rest)
        if name =~ /result$/i
          define_method(:result) do
            self[name]
          end
        end
      end
    end

    attr_reader :attributes, :http_response
    delegate :code, :message, to: :http_response

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
