require "aws/errors"

module R53
  class InvalidChangeBatchError < AWS::Error
    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super(errors.join(" - "))
    end
  end
end
