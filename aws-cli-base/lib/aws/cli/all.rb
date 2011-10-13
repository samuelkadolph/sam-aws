require "active_support/concern"

module AWS
  module CLI
    module All
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def can_show_all
            method_option :show_all, aliases: "-A", default: true, type: :boolean, desc: "Show all items"
            method_option :marker, aliases: "-M", desc: "Shows items after the marker"
          end
      end

      def show_all(method, *args)
        if options[:show_all]
          verb, collection_method = AWS::Account.send(:split_verb_from_collection_name, method)
          account.send(:"#{verb}_all_#{collection_method}", *args)
        else
          account.send(method, *args)
        end
      end
    end
  end
end
