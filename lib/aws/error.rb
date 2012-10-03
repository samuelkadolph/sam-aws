require "active_support/core_ext/class/attribute"
require "active_support/core_ext/string/inflections"

module AWS
  class Error < StandardError
  end

  class APIError < Error
    class_attribute :errors, :abstract_errors, instance_reader: false, instance_writer: false
    self.errors = Hash.new(self)
    self.abstract_errors = [/::APIError$/]

    class << self
      def abstract_error?
        abstract_errors.any? { |e| e === name }
      end

      def error_name
        name.demodulize.gsub(/(API)?Error$/, "")
      end

      def inherited(klass)
        errors[klass.error_name] = klass unless klass.abstract_error?
      end
    end

    def initialize(code, message)
      if self.class.abstract_error?
        super("#{code} - #{message}")
      else
        super(message)
      end
    end
  end
end
