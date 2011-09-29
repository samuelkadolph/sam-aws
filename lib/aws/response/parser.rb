require "nokogiri"

module AWS
  class Response
    class Parser < Nokogiri::XML::SAX::Document
      class ParserError < Error
      end

      attr_reader :pusher, :response, :response_pool

      def initialize(http_response, response_pool = RESPONSES)
        @http_response, @response_pool = http_response, response_pool
        @pusher = Nokogiri::XML::SAX::PushParser.new(self)

        self.buffer, self.response, self.stack = "", nil, []

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
        if stack.empty?
          self.response = find_response(name).new(@http_response)
          stack.push(response)
        elsif name == "member"
          case array = stack.last
          when ValueArray
            # leave value array as top of stack
          when StructArray
            stack.push(array.new)
          else
            raise "encountered array when not expecting one"
          end
        else
          property = stack.last.send(name)

          case property
          when Struct, StructArray, ValueArray
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
        if name == "member"
          case stack.last
          when Struct
            stack.pop
          else
            stack.last << buffer
          end
        else
          case property = stack.pop
          when Struct, StructArray, ValueArray
            # pop is all we have to do
          when String
            stack.last.send("#{property}=", buffer)
          end
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
        attr_accessor :buffer, :stack
        attr_writer :response
    end
  end
end
