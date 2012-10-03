require "active_support/concern"
require "active_support/core_ext/class/attribute"
require "active_support/hash_with_indifferent_access"

module AWS
  module CLI
    class Base
      module Types
        extend ActiveSupport::Concern

        included do
          no_tasks do
            class_attribute :types, instance_writer: false
            self.types = []
          end

          class Option < OptionBase
          end
          class Options < OptionsBase
          end
        end

        def initialize(args=[], options={}, config={})
          # Thor::Invocation#initialize
          @_invocations = config[:invocations] || Hash.new { |h,k| h[k] = [] }
          @_initializer = [ args, options, config ]

          # Thor::Base#initialize
          args = Thor::Arguments.parse(self.class.arguments, args)
          args.each { |key, value| send("#{key}=", value) }

          parse_options = self.class.class_options

          if options.is_a?(Array)
            task_options  = config.delete(:task_options) # hook for start
            parse_options = parse_options.merge(task_options) if task_options
            array_options, hash_options = options, {}
          else
            array_options, hash_options = [], options
          end

          opts = self.class::Options.new(parse_options, hash_options)
          self.options = opts.parse(array_options)
          opts.check_unknown! if self.class.check_unknown_options?(config)

          # Thor::Shell#initialize
          self.shell = config[:shell]
          self.shell.base ||= self if self.shell.respond_to?(:base)
        end

        module ClassMethods
          protected
            def build_option(name, options, scope)
              scope[name] = self::Option.new(name, options[:desc], options[:required],
                                             options[:type], options[:default], options[:banner],
                                             options[:lazy_default], options[:group], options[:aliases])
            end

          private
            def type(mapping, &block)
              mapping.each do |klass, banner|
                type = klass.name.demodulize.underscore.to_sym
                self::Option.register(type, banner)
                self::Options.register(type, block)
              end
            end
        end

        class OptionBase < Thor::Option
          class_attribute :type_banners, :valid_types, instance_writer: false
          self.type_banners = {}
          self.valid_types = Thor::Option::VALID_TYPES.dup

          class << self
            def register(type, banner)
              self.type_banners = type_banners.merge(type => banner)
              self.valid_types += [type]
            end
          end

          protected
            def default_banner
              case type
              when *Thor::Option::VALID_TYPES
                super
              when *valid_types
                type_banners[type]
              else
                nil
              end
            end

            def valid_type?(type)
              valid_types.include?(type.to_sym)
            end
        end

        class OptionsBase < Thor::Options
          class << self
            def register(type, block)
              define_method("parse_#{type}") do |switch|
                instance_exec(switch, &block)
              end
            end
          end

          def parse(*)
            ActiveSupport::HashWithIndifferentAccess.new(super)
          end
        end
      end
    end
  end
end
