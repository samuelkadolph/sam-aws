module Generators
  module Chunks
    class CLIMethod < ActionBase
      contents do
        line %Q{desc "#{method.tr("_", "-")}", "#{description[/([^.]+\.)/, 1]}"}
        line options if options?
        line show_all if show_all?
        line %Q{table_method_options} if tableize?
        line %Q{def #{method}}
        line 2, body
        line %Q{end}
      end

      def body
        contents do
          if method =~ /^describe_(.*)$/
            collection = $1
            if parameters.any? { |p| p.name =~ /Marker|NextToken/ }
              line %Q{#{collection} = show_all(:describe, :#{collection}, options)}
            else
              line %Q{#{collection} = account.describe_#{collection}!} << (parameters.any? ? "(options)" : "")
            end
            line %Q{tableize_#{collection}(#{collection}).print}
          elsif method =~ /^list_(.+)$/
            collection = $1
            if parameters.any? { |p| p.name =~ /Marker|NextToken/ }
              line %Q{#{collection} = show_all(:list, :#{collection}, options)}
            else
              line %Q{#{collection} = account.list_#{collection}!} << (parameters.any? ? "(options)" : "")
            end
            line %Q{tableize_#{collection}(#{collection}).print}
          else
            line %Q{account.#{method}!} << (parameters.any? ? "(options)" : "")
          end
        end
      end

      def method
        name.underscore
      end

      def options
        parameters.reject { |p| p.name =~ /Marker|NextToken/ }.map do |parameter|
          line  = %Q{method_option :#{parameter.name.underscore}}
          # line << %Q{, aliases: ""}
          # line << %Q{, banner: ""}
          # line << %Q{, default: }
          line << %Q{, desc: "#{parameter.description}"}
          line << %Q{, required: true} if parameter.required?
          line << %Q{, type: :#{cli_type(parameter)}}
          line
        end
      end

      def cli_type(parameter)
        return "array" if parameter.type.array?

        case parameter.type.name
        when "Integer", "Float"
          "numeric"
        else
          parameter.type.name.underscore
        end
      end

      def options?
        parameters.any?
      end

      def tableize?
        method =~ /^describe_/
      end

      def show_all
        all  = %Q{show_all_method_options}
        all << " :next_token" if parameters.any? { |p| p.name =~ /NextToken/ }
        all
      end

      def show_all?
        parameters.any? { |p| p.name =~ /Marker|NextToken/ }
      end
    end

    module CLI
      class TypesChunk < TypesBase
        contents do
          types.each do |type|
            line %Q{type #{type.name} => "" do}
            line %Q{end}
          end
        end
      end
    end
  end
end
