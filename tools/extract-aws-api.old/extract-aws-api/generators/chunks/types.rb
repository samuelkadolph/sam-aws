module Generators
  module Chunks
    class DataTypeClass < DataTypeBase
      contents do
        line %Q{class #{name} < Type}
        line 2, params
        line %Q{end}
      end

      def params
        parameters.map do |parameter|
          type = parameter.type
          "#{type.array? ? "array" : "field"} :#{parameter.name}" << specify_type(type)
        end
      end

      private
        def specify_type(type)
          case type.name
          when "String"
            ""
          else
            ", " << type.name
          end
        end
    end
  end
end
