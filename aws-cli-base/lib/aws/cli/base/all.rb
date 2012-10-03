require "active_support/concern"

module AWS
  module CLI
    class Base
      module All
        extend ActiveSupport::Concern

        module ClassMethods
          private
            def show_all_method_options(marker = :marker)
              method_option marker, aliases: "-M", desc: "Shows items after the marker", group: "Pagin"
              method_option :page, aliases: "-P", type: :numeric, desc: "Show a specific page of items", group: "Paging"
              method_option :show_all, aliases: "-A", default: true, type: :boolean, desc: "Show all items", group: "Paging"
            end
        end

        def show_all(verb, collection, *args)
          if options[:show_all]
            account.send("#{verb}_all_#{collection}", *args)
          elsif options[:page]
            raise NotImplmentedError
          else
            account.send("#{verb}_#{collection}!", *args)
          end
        end
      end
    end
  end
end
