module AWS
  class Request
    @@methods = {}
    def self.Method(value)
      value = value.to_s.upcase
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        module #{value}Method
          class << self
            def to_s; #{value.inspect}; end
            alias inspect to_s
            alias to_str to_s
          end
        end
        @@methods[#{value.inspect}] = #{value}Method
      RUBY
    end

    Method "DELETE"
    Method "GET"
    Method "POST"
    Method "PUT"
  end
end
