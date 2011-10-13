module SES
  module ParamsContent
    def content; @content ||= Content.new(self) end

    class Content < AWS::Connection::Params::Base
      def []=(name, content)
        if content
          params["#{name}.Charset"] = content.encoding.to_s
          params["#{name}.Data"] = content
        end
      end
    end
  end
end
