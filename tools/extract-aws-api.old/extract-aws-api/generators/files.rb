module Generators
  module Files
    class Main < APIBase
      contents do
        line %Q{require "aws"}
        line
        line %Q{# #{name}}
        line %Q{module #{mod}}
        line %Q{  VERSION = AWS::VERSION}
        line
        line %Q{  require "#{dir}/account"}
        line %Q{  require "#{dir}/errors"} if errors?
        line %Q{  require "#{dir}/responses"}
        line %Q{  require "#{dir}/types"}
        line %Q{end}
      end
    end

    class Account < APIBase
      contents do
        line %Q{require "aws/account"}
        line
        line %Q{module #{mod}}
        line %Q{  require "#{dir}/types"}
        line
        line %Q{  class Account < AWS::Account}
        line 4, includes
        line
        line 4, constants
        line and line 4, params if params?
        line
        line 4, methods
        line %Q{  end}
        line %Q{end}
      end

      def constants
        Chunks::AccountConstants.new(api)
      end

      def includes
        Chunks::AccountIncludes.new(api)
      end

      def methods
        actions.map { |action| Chunks::AccountMethod.new(action) }
      end

      def params
        Chunks::AccountParams.new(actions.map(&:parameters).flatten.map(&:type).select(&:custom?).uniq.sort)
      end

      def params?
        actions.any? { |action| action.parameters.any? { |parameter| parameter.type.custom? } }
      end
    end

    class Errors < APIBase
      contents do
        line %Q{require "aws/errors"}
        line
        line %Q{module #{mod}}
        line %Q{  # APIError class for #{mod}.}
        line %Q{  class APIError < AWS::APIError}
        line %Q{  end}
        line and line 2, errors if errors?
        line %Q{end}
      end

      def errors
        api.errors.map { |error| Chunks::ErrorClass.new(error) }
      end

      def errors?
        api.errors.any?
      end
    end

    class Responses < APIBase
      contents do
        line %Q{require "aws/response"}
        line %Q{require "aws/responses"}
        line
        line %Q{module #{mod}}
        line %Q{  require "#{dir}/types"}
        line
        line %Q{  class Response < AWS::MetadataResponse}
        line %Q{  end}
        line
        line 2, responses
        line %Q{end}
      end

      def responses
        actions.map { |action| Chunks::ResponseClass.new(action) }
      end
    end

    class Types < APIBase
      contents do
        line %Q{require "aws/type"}
        line
        line %Q{module EBS}
        line %Q{  class Type < AWS::Type}
        line %Q{  end}
        line
        line 2, types
        line %Q{end}
      end

      def types
        ordered_data_types.map { |data_type| Chunks::DataTypeClass.new(data_type) }
      end

      def ordered_data_types
        data_types.sort.reduce([]) do |order, data_type|
          order | dependencies_for_type(data_type) | [data_type]
        end
      end

      def dependencies_for_type(type)
        type.parameters.reduce([]) do |dependencies, parameter|
          if parameter.type.custom?
            data_type = data_type_for(parameter.type)
            dependencies | dependencies_for_type(data_type) | [data_type]
          else
            dependencies
          end
        end
      end
    end

    module CLI
      class Bin < APIBase
        contents do
          line %Q{#!/usr/bin/env ruby}
          line %Q{}
          line %Q{require "#{dir}/cli"}
          line %Q{#{mod}::CLI::Main.start}
        end
      end

      class Main < APIBase
        contents do
          line %Q{require "aws/cli/base"}
          line %Q{require "#{dir}"}
          line
          line %Q{module #{mod}}
          line %Q{  module CLI}
          line %Q{    class Main < AWS::CLI::Base}
          line 6, body
          line %Q{    end}
          line %Q{  end}
          line %Q{end}
        end

        def body
          contents do
            line %Q{namespace "#{dir}"}
            line and line types if types?
            line
            line methods
            line
            line %Q{protected}
            line %Q{  def account}
            line %Q{    @account ||= #{mod}::Account.new(access_key: access_key, secret_key: secret_key)}
            line %Q{  end}
            line and line privates if privates?
          end
        end

        def methods
          actions.map { |action| Chunks::CLIMethod.new(action) }
        end

        def privates
          contents do
            line %Q{private}
            line 2, tableize_methods
          end
        end

        def privates?
          actions.any? { |action| action.name.underscore =~ /^describe_/ }
        end

        def tableize_methods
          actions.select { |action| action.name.underscore =~ /^describe_/ }.map do |action|
            collection = action.name.underscore[/^describe_(.+)$/, 1]
            contents do
              line %Q{def tableize_#{collection}(#{collection})}
              line %Q{end}
            end
          end
        end

        def types
          Chunks::CLI::TypesChunk.new(actions.map(&:parameters).flatten.map(&:type).select(&:custom?).uniq.sort)
        end

        def types?
          actions.any? { |action| action.parameters.any? { |parameter| parameter.type.custom? } }
        end
      end
    end
  end
end
