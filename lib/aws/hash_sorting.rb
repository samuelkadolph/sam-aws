require "active_support/concern"

module AWS
  module HashSorting
    extend ActiveSupport::Concern

    def sort
      dup.sort!
    end

    def sort!
      replace(Hash[sort_by { |k, v| k }])
    end
  end
end
