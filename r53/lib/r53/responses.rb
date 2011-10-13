require "aws/response"

module R53
  class ChangeInfoResponse < Response
    struct :change_info do
      field :id
      field :status, %W[INSYNC PENDING]
      field :submitted_at, DateTime
    end

    def synced?
      change_info.status == "INSYNC"
    end

    def pending?
      change_info.status == "PENDING"
    end
  end

  class ChangeResourceRecordSetsRequest < ChangeInfoResponse
  end

  class CreateHostedZoneResponse < ChangeInfoResponse
    delegation_set
    hosted_zone
  end

  class DeleteHostedZoneResponse < ChangeInfoResponse
  end

  class GetChangeResponse < ChangeInfoResponse
  end

  class GetHostedZoneResponse < Response
    delegation_set
    hosted_zone
  end

  class ListHostedZonesResponse < Response
    hosted_zones
    field :is_truncated, :boolean
    field :marker
    field :max_items
    field :next_marker
  end

  class ListResourceRecordSetsResponse < Response
    field :is_truncated, :boolean
    field :max_items
    field :next_record_name
    field :next_record_type
    resource_record_sets
  end

  class InvalidChangeBatch < Response
    array :messages

    def error?
      true
    end

    def error
      InvalidChangeBatchError.new(messages)
    end
  end
end
