require "active_support/concern"

module AWS
  class Account
    module All
      extend ActiveSupport::Concern

      module ClassMethods
        private
        def all(verb, collection, marker = :marker)
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{verb}_all_#{collection}(*args)
              options = args.last.is_a?(Hash) ? args.pop.dup : {}
              collection = []

              result = #{verb}_#{collection}!(*(args << options)).result
              collection.concat(result.#{collection})

              while result.marker
                options[:#{marker}] = result.#{marker}

                result = #{verb}_#{collection}!(*(args << options)).result
                collection.concat(result.#{collection})
              end

              collection
            end
          RUBY
        end
      end
    end
  end
end
