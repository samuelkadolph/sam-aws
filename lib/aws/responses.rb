module AWS
  ABSTRACT_RESPONSES << "AWS::MetadataResponse"

  class MetadataResponse < Response
    struct :response_metadata do
      field :request_id
    end
  end

  class ErrorResponse < Response
    struct :error do
      field :type
      field :code
      field :message
    end
    field :request_id

    def error?
      true
    end

    def build_error
      Error.new([error.code, error.message].compact.join(": "))
    end
  end

  class AccessDeniedException < Response
    field :message
  end

  class GetUserResponse < MetadataResponse
    struct :get_user_result, :result do
      struct :user do
        field :arn
        field :create_date, DateTime
        field :path
        field :user_id, :id
        field :user_name, :name
      end
    end
  end
end
