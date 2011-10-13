require "active_support/concern"

module R53
  module CLI
    module WaitForChangeToSync
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def can_wait_for_change_to_sync
            method_option :wait, aliases: "-w", default: false, type: :boolean,
                                 desc: "Makes the command wait until the change has been completed"
            method_option :wait_delay, aliases: "-W", default: 1, type: :numeric,
                                       desc: "The number of seconds to wait between checking if a change has been completed"
          end
      end

      private
        def wait_for_change_to_sync
          response = intermediate = yield
          return response unless response.pending? and options[:wait]

          print "Waiting for changes to sync"

          while intermediate.pending?
            sleep options[:wait_delay]
            print "."
            intermediate = account.get_change!(intermediate.ChangeInfo.Id)
          end

          puts

          response.ChangeInfo = intermediate.ChangeInfo
          response
        end
    end
  end
end
