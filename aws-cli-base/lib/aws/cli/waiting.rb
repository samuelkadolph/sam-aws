require "active_support/concern"

module AWS
  module CLI
    module Waiting
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def can_wait_until_done
            method_option :wait_until_done, aliases: "-w", default: false, type: :boolean,
                          desc: "Will wait until the command is done"
            method_option :wait_until_done_delay, aliases: "-W", default: 5, type: :numeric,
                          desc: "How long to wait between the checks for command being done"
          end
      end

      def wait_until_done(what, method = :status, check = "available")
        return unless options[:wait_until_done] and what.send(method) != check

        print "Waiting until done"
        while what.send(method) != check
          sleep options[:wait_until_done_delay]
          print "."
          what = yield
        end
        puts " done!"
      end
    end
  end
end
