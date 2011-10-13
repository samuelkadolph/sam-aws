require "aws/response"

module R53
  AWS::ABSTRACT_RESPONSES << "R53::Response"

  class Response < AWS::Response
    class << self
      private
        def delegation_set
          struct :delegation_set do
            array :name_servers
          end
        end

        def hosted_zone
          struct :hosted_zone do
            hosted_zone_properties
          end
        end

        def hosted_zones
          array :hosted_zones do
            hosted_zone_properties
          end
        end

        def hosted_zone_properties
          field :caller_reference
          struct :config do
            field :comment
          end
          field :id
          field :name
        end

        def resource_record_set
          struct :resource_record_set do
            resource_record_set_properties
          end
        end

        def resource_record_sets
          array :resource_record_sets do
            resource_record_set_properties
          end
        end

        def resource_record_set_properties
          struct :alias_target do
            field :dns_name
            field :hosted_zone_id
          end
          field :name
          array :resource_records do
            field :value
          end
          field :set_identifier
          field :ttl, Fixnum
          field :type
          field :weight, Fixnum
        end
    end
  end
end
