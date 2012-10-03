require "active_support/concern"

module AWS
  module CLI
    class Base
      module Waiting
        extend ActiveSupport::Concern

        module ClassMethods
          private
            def wait_until_done_method_options
              method_option :wait_until_done, aliases: "-W", default: false, desc: "Will wait until the command is done", group: "Waiting", type: :boolean
              method_option :wait_until_done_delay, aliases: "-WD", default: 5, desc: "How long to wait between the checks for command being done", group: "Waiting", type: :numeric
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
end
