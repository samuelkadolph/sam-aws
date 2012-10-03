module AWS
  module Typing
    class Boolean
    end

    def Boolean(string)
      string == "true" ? true : false
    end
  end
end
