require "time"

module AWS
  require "aws/hash_sorting"

  class Connection
    class Params < Hash
      include HashSorting

      def initialize
        super
      end

      def array;    @array    ||= Array.new(self)    end
      def datetime; @datetime ||= DateTime.new(self) end
      def hash;     @hash     ||= Hash.new(self)     end
      def option;   @option   ||= Option.new(self)   end

      class Base
        attr_reader :params
        delegate :[], :inspect, :to_s, :to => :params
        def initialize(params) @params = params end
      end

      class Array < Base
        def []=(name, array)
          array.each_with_index do |item, n|
            params["#{name}.member.#{n + 1}"] = item
          end if array
        end

        def hash; @hash ||= ArrayHash.new(params); end
      end

      class ArrayHash < Base
        def []=(name, mapping = nil, array)
          array.each_with_index do |item, n|
            params.hash["#{name}.member.#{n + 1}", mapping] = item
          end if array
        end
      end

      class DateTime < Base
        def []=(name, value)
          params[name] = value.iso8601 if value
        end
      end

      class Hash < Base
        def []=(name, mapping = nil, hash)
          if hash
            if mapping
              mapping.each do |param, key|
                params["#{name}.#{param}"] = hash[key] if hash[key]
              end
            else
              hash.each do |key, value|
                params["#{name}.#{key}"] = value
              end
            end
          end
        end
      end

      class Option < Base
        def []=(name, value)
          params[name] = value if value
        end
      end

      def add_array(name, array)
        array.each_with_index do |item, n|
          self["#{name}.member.#{n + 1}"] = item
        end if array
      end

      def add_array_of_hashes(name, array, mapping)
        array.each_with_index do |hash, n|
          add_hash("#{name}.member.#{n + 1}", hash, mapping)
        end if array
      end

      def add_content(name, content)
        if content
          self["#{name}.Charset"] = content.encoding.to_s
          self["#{name}.Data"] = content
        end
      end

      def add_hash(name, hash, mapping)
        mapping.each do |param, key|
          self["#{name}.#{param}"] = hash[key] if hash.key?(key)
        end if hash
      end

      def add_option(name, option)
        self[name] = option if option
      end
    end
  end
end
