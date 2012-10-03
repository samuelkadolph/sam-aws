module AWS
  require "aws/typing"

  class Type
    include Typing

    def initialize(*args)
      super()
      props = args.last.is_a?(Hash) ? args.pop : {}
      # properties.keys.zip(args).each { |name, value| props[name] = value }
      props.each { |name, value| send("#{name.to_s.underscore}=", value) }
    end
  end
end
