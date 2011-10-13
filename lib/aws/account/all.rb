require "active_support/concern"

module AWS
  class Account
    module All
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def all(symbol, marker = :marker)
            verb, collection_name = split_verb_from_collection_name(symbol)

            class_eval <<-RUBY, __FILE__, __LINE__ + 1
              def #{verb}_all_#{collection_name}!(*args)
                collection = []

                options = args.last.is_a?(Hash) ? args.pop.dup : {}
                result = #{symbol}!(*(args << options)).result
                collection.concat(result.#{collection_name})

                while result.#{marker}
                  options[:marker] = result.#{marker}

                  result = #{symbol}!(*(args << options)).result
                  collection.concat(result.#{collection_name})
                end

                collection
              end
            RUBY
          end

          def split_verb_from_collection_name(symbol)
            if symbol =~ /^([^_]+)_(.+)$/
              [$1, $2]
            else
              raise "#{symbol} must match verb_collection_name"
            end
          end
      end
    end
  end
end
