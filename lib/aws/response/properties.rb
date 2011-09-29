module AWS
  class Response
    module Properties
      def properties
        @properties ||= self < Response ? superclass.properties.dup : {}
      end

      private
        @@stack = []
        def struct(name, &block)
          build_property(name, build_struct(name, &block))
        end

        def array(name, klass = String, &block)
          if block_given?
            array = StructArray(build_struct(name, &block))
          else
            array = ValueArray(klass)
          end

          build_property(name, array)
        end

        def field(name, klass = String)
          # TODO: klass handling including parsing strings to klass
          build_property(name, Field(nil))
        end

        def build_struct(name)
          @@stack << {}
          yield
          Struct(@@stack.pop)
        end

        def build_property(name, type)
          raise ArgumentError, "type must respond_to new" unless type.respond_to?(:new)

          if @@stack.empty?
            define_method(name) do
              self[name] ||= type.new
            end
            define_method("#{name}=") do |value|
              self[name] = value
            end
            # define_method("#{name}_type") do
            #   type
            # end
            properties[name] = type
          else
            @@stack.last[name] = type
          end
        end
    end
  end
end
