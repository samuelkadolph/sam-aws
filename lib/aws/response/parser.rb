require "active_support/core_ext/module/delegation"
require "active_support/core_ext/string/inflections"
require "nokogiri"

module AWS
  require "aws/error"

  class Response
    class Parser < Nokogiri::XML::SAX::Document
      class KeyValuePair
        attr_accessor :key, :klass, :value

        def initialize(klass)
          self.klass = klass
        end
      end

      class ParserError < Error
      end

      attr_reader :response, :response_pool

      delegate :parse, to: :parser

      def initialize(http_response)
        @http_response = http_response
        self.buffer, self.parser, self.stack = "", Nokogiri::XML::SAX::Parser.new(self), []

        if block_given?
          yield self
        end
      end

      def start_element(name, attributes = [])
        case stack.last
        when nil
          self.response = find_response(name).new(@http_response, attributes)
          stack.push(response)
        when Typing
          case property = stack.last[name.underscore]
          when Typing, Typing::TypeArray
            stack.push(property)
          when Typing::TypeHash
            stack.push(property)
          else
            stack.push(name.underscore)
          end
        when Typing::TypeArray
          if stack.last.klass <= Typing
            stack.push(stack.last.new)
          else
            stack.push(:entry)
          end
        when Typing::TypeHash
          stack.push(KeyValuePair.new(stack.last.klass))
        when KeyValuePair
          if name == "key"
            stack.push(:key)
          elsif stack.last.klass <= Typing
            stack.push(stack.last.value = stack.last.klass.new)
          else
            stack.push(:value)
          end
        end

        self.buffer = ""
      end

      def characters(characters)
        buffer << characters
      end

      def end_element(name)
        case stack.last
        when Typing, Typing::TypeArray, Typing::TypeHash
          stack.pop
        when :entry
          stack.pop
          stack.last << buffer
        when KeyValuePair
          kvp = stack.pop
          stack.last[kvp.key] = kvp.value
        when :key
          stack.pop
          stack.last.key = buffer
        when :value
          stack.pop
          stack.last.value = buffer
        when String
          property = stack.pop
          stack.last[property] = buffer
        when Response
          stack.pop
        end

        self.buffer = ""
      end

      protected
      def find_response(name)
        response = Response.responses[name]
        raise ParserError, "unknown response '#{name}'" unless response
        response
      end

      private
      attr_accessor :buffer, :parser, :stack
      attr_writer :response
    end
  end
end
