module Generators
  module Chunks
    class AccountConstants < APIBase
      contents do
        line %Q{DEFAULT_OPTIONS = { #{default_options} }}
        line %Q{VERSION = "#{version}"} if version?
      end

      def default_options
        hash = {}
        hash[:endpoint] = endpoint if endpoint?
        hash[:region] = region if region?

        hash.map { |k,v| "#{k}: #{v.inspect}" }.join(", ")
      end
    end

    class AccountIncludes < APIBase
      contents do
        line %Q{include AWS::Account::Endpoint} if endpoint?
        line %Q{include AWS::Account::Region} if region?
        line %Q{include AWS::Account::VersionInQuery} if version?
      end
    end

    class AccountMethod < ActionBase
      contents do
        line documentation.comment
        line %Q{def #{method}#{"(options = {})" unless parameters.empty?}}
        line 2, body
        line %Q{end}
        line and line bang
        line and line all if all?
      end

      def all
        verb, collection = method =~ /^([^_]+)_(.+)$/ && [$1, $2]
        contents do
          line %Q{# @raise [#{raises}]}
          line %Q{# @return [#{all_return(collection)}]}
          line %Q{all :#{verb}, :#{collection}} << all_marker
        end
      end

      def all?
        parameters.any? do |parameter|
          parameter.name =~ /Marker|NextToken/
        end
      end

      def all_marker
        parameters.each do |parameter|
          return ", :next_token" if parameter.name =~ /NextToken/
        end

        ""
      end

      def all_return(collection)
        response.contents.first[1] || "Array"
      end

      def bang
        contents do
          line %Q{# @raise [#{raises}]}
          line %Q{# @return [#{name}Response]}
          line %Q{bang :#{name.underscore}}
        end
      end

      def body
        contents do
          if parameters.empty?
            line %Q{auto "Action" => "#{name}"}
          else
            line %Q{auto "Action" => "#{name}" do}
            line 2, %Q{self.options = options}
            # line
            line 2, params
            line %Q{end}
          end
        end
      end

      def documentation
        documentation  = []
        documentation << description
        documentation << "@param [Hash] options Options for the API call" unless parameters.empty?
        documentation.concat(parameters.map do |parameter|
          type = parameter.type.name == "Boolean" ? "true, false" : parameter.type.name
          str  = ""
          str << "@option options [#{type}] :#{parameter.name.underscore} "
          str << "(#{parameter.default}) " if parameter.default?
          str << "*Required* -- " if parameter.required?
          str << "_#{parameter.name}_ -- " << parameter.description
          str
        end)
        documentation << "@return [#{name}Response, AWS::ErrorResponse]"
        documentation
      end

      def method
        name.underscore
      end

      def params
        parameters.map do |parameter|
          str  = parameter.type.name.underscore
          str << ".array" if parameter.type.array?
          str << ".required" if parameter.required?
          str << %Q{["#{parameter.name}"] = :#{parameter.name.underscore}}
          str
        end
      end

      def raises
        all_errors.join(", ")
      end
    end

    class AccountParams < TypesBase
      contents do
        types.each do |type|
          line %Q{auto add: #{type.name}}
        end
      end
    end
  end
end
