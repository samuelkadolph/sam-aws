require "active_support/concern"

module AWS
  module CLI
    module Tables
      extend ActiveSupport::Concern

      module ClassMethods
        private
          def can_tableize_output
            method_option :headers, default: true, type: :boolean
            method_option :silence, desc: "Silence output", default: false, type: :boolean
            method_option :tableize, default: true, type: :boolean
          end
      end

      private
        def table(&block)
          Table.new(options[:silence], &block)
        end

        def tablize(collection, mapping)
        end
    end

    class Table
      attr_reader :rows
      attr_accessor :silenced
      alias silenced? silenced

      def initialize(silenced = false, &block)
        @header, @rows = [], []
        @silenced = silenced
        instance_exec(&block) if block_given?
      end

      def header(*columns)
        @header = columns unless columns.empty?
        @header
      end

      def row(*columns)
        @rows << columns
      end

      def print(out = $stdout)
        out.puts self unless silenced?
      end

      def to_s
        widths = column_widths

        str = ""
        str << make_row(header, " | ", widths) << $/
        str << rows.map { |row| make_row(row, " | ", widths) }.join($/)
        str
      end

      private
        def column_widths
          (0...column_count).map do |col|
            ([header] + rows).map { |row| col < row.size ? row[col].to_s.size : 0 }.max
          end
        end

        def column_count
          ([header] + rows).map { |row| row.size }.max
        end

        def make_row(row, sep, widths)
          row.map.with_index do |col, i|
            case col
            when Numeric
              col.to_s.rjust(widths[i])
            else
              col.to_s.ljust(widths[i])
            end
          end.join(sep)
        end
    end
  end
end
