require "aws/response"

module SES
  require "ses/types"

  class DeleteIdentityResponse < AWS::MetadataResponse
    field :DeleteIdentityResult
  end

  class DeleteVerifiedEmailAddressResponse < AWS::MetadataResponse
  end

  class GetSendQuotaResponse < AWS::MetadataResponse
    field :GetSendQuotaResult, GetSendQuotaResult
  end

  class GetSendStatisticsResponse < AWS::MetadataResponse
  end

  class ListVerifiedEmailAddressesResponse < AWS::MetadataResponse
  end

  class SendEmailResponse < AWS::MetadataResponse
  end

  class SendRawEmailResponse < AWS::MetadataResponse
  end

  class VerifyEmailAddressResponse < AWS::MetadataResponse
  end

  class VerifyEmailIdentityResponse < AWS::MetadataResponse
    field :VerifyEmailIdentityResult, VerifyEmailIdentityResult
  end

  class ListIdentitiesResponse < AWS::MetadataResponse
    field :ListIdentitiesResult, ListIdentitiesResult
  end

  class GetIdentityDkimAttributesResponse < AWS::MetadataResponse
    field :GetIdentityDkimAttributesResult, GetIdentityDkimAttributesResult
  end
end
