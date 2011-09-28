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

          puts "<#{name}>"
        if stack.empty?
          self.response = find_response(name).new(@http_response)
          stack.push(response)
          # stack.push(name: name, type: :struct, proc: lambda { response })
        elsif name == "member"
          stack.push(stack.last)
          # noop
        else
          property = stack.last.send(name)
          case property
          when Struct, ValueArray
            stack.push(property)
          when StructArray
            stack.push(property.new)
          else
            # don't push into stack
          end

          # previous = stack.last
          # current = { name: name, type: :field }
          #
          # case previous[:proc].call
          # when Array
          #   previous[:type] = :array
          #   current[:proc] = lambda { previous[:proc].call.new }
          # else
          #   previous[:type] = :struct
          #   current[:proc] = lambda { previous[:proc].call.send(name) }
          # end
          #
          # stack.push(current)
        end
      end

      def characters(characters)
        buffer << characters
      end

      def end_element(name)
        puts "</#{name}>"
        # self.buffer = "" unless stack.last.send()

        unless buffer.empty?
          value, self.buffer = buffer, ""

          if name == "member"
            puts
            puts
            puts stack
            puts
            p stack.last.class
            p ValueArray === stack.last
            stack.last.push(value.strip)
          # elsif stack.last
          elsif stack.last.send("#{name}") == nil
            stack.last.send("#{name}=", value.strip)
          end
        end

        stack.pop
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
