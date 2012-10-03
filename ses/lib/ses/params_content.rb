require "aws/connection/parameters"

module SES
  module ParamsContent
    class Content < AWS::Connection::Parameters
      def []=(name, content)
        if content
          params["#{name}.Charset"] = content.encoding.to_s
          params["#{name}.Data"] = content
        end
      end
    end

    def content
      return @content if defined?(@content)
      @content = Content.new(self)
    end
  end
end
