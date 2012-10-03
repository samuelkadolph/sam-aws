module AWS
  require "aws/type"
  require "aws/types"

  Response.abstract_responses += %W[AWS::MetadataResponse]

  class MetadataResponse < Response
    field :ResponseMetadata, ResponseMetadata
  end

  class ErrorResponse < Response
    class Error < Type
      field :Code
      field :Message
      field :Type
    end

    field :Error, Error
    field :RequestId

    def build_error
      APIError.errors[error.code].new(error.code, error.message)
    end

    def error?
      true
    end
  end

  class AccessDeniedException < Response
    field :Message

    # TODO
  end
end

module IAM
  class GetUserResponse < AWS::MetadataResponse
    class User < AWS::Type
      field :Arn
      field :CreateDate, DateTime
      field :Path
      field :UserId
      field :UserName

      alias id user_id
      alias name user_name
    end

    class GetUserResult < AWS::Type
      field :User, User
    end

    field :GetUserResult, GetUserResult
  end
end
