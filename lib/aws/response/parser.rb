require "active_support/core_ext/string/inflections"
require "nokogiri"

module AWS
  class Response
    class Parser < Nokogiri::XML::SAX::Document
      attr_reader :response, :response_pool

      def initialize(http_response, response_pool = RESPONSES)
        @http_response, @response_pool = http_response, response_pool
        self.buffer, self.pusher, self.stack = "", Nokogiri::XML::SAX::PushParser.new(self), []

        if block_given?
          yield self
          finish
        end
      end

      def write(chunk, last_chunk = false)
        pusher.write(chunk, last_chunk)
      end
      alias << write

      def finish
        pusher.finish
      end

      def start_element(name, attributes = [])
        case stack.last
        when nil
          stack.push(self.response = find_response(name).new(@http_response, attributes))
        when Types::StructArray
          stack.push(stack.last.add)
        when Types::ValueArray
          stack.push(:value)
        when Types::Struct, Response
          name = name.underscore
          case property = stack.last.send(name)
          when Types::Struct, Types::StructArray, Types::ValueArray
            stack.push(property)
          else
            stack.push(name)
          end
        end

        self.buffer = ""
      end

      def characters(characters)
        buffer << characters
      end

      def end_element(name)
        case stack.last
        when Types::Struct, Types::StructArray, Types::ValueArray
          stack.pop
        when :value
          stack.pop
          stack.last << buffer
        when String
          property = stack.pop
          stack.last.send("#{property}=", buffer)
        when Response
          stack.pop
        end

        self.buffer = ""
      end

      protected
        def find_response(name)
          response = response_pool[name]
          raise ParserError, "unknown response '#{name}'" unless response
          response
        end

      private
        attr_accessor :buffer, :pusher, :stack
        attr_writer :response
    end
  end
end
