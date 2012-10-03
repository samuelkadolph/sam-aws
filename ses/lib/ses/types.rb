require "aws/type"

module SES
  class IdentityDkimAttributes < AWS::Type
    field :DkimEnabled, Boolean
    field :DkimTokens
    field :DkimVerificationStatus
  end

  class IdentityNotificationAttributes < AWS::Type
    field :BounceTopic
    field :ComplaintTopic
    field :ForwardingEnabled, Boolean
  end

  class IdentityVerificationAttributes < AWS::Type
    field :VerificationStatus
    field :VerificationToken
  end

  class SendDataPoint < AWS::Type
    field :Bounces, Bignum
    field :Complaints, Bignum
    field :DeliveryAttempts, Bignum
    field :Rejects, Bignum
    field :Timestamp, DateTime
  end

  class DeleteIdentityResult < AWS::Type
  end

  class GetIdentityDkimAttributesResult < AWS::Type
    hash :DkimAttributes, IdentityDkimAttributes
  end

  class GetIdentityNotificationAttributesResult < AWS::Type
    hash :NotificationAttributes, IdentityNotificationAttributes
  end

  class GetIdentityVerificationAttributesResult < AWS::Type
    hash :VerificationAttributes, IdentityVerificationAttributes
  end

  class GetSendQuotaResult < AWS::Type
    field :Max24HourSend, Float
    field :MaxSendRate, Float
    field :SentLast24Hours, Float
  end

  class GetSendStatisticsResult < AWS::Type
    array :SendDataPoints, SendDataPoint
  end

  class ListIdentitiesResult < AWS::Type
    array :Identities
    field :NextToken
  end

  class ListVerifiedEmailAddressesResult < AWS::Type
    array :VerifiedEmailAddresses
  end

  class SendEmailResult < AWS::Type
    field :MessageId
  end

  class SendRawEmailResult < SendEmailResult
  end

  class SetIdentityDkimEnabledResult < AWS::Type
  end

  class SetIdentityFeedbackForwardingEnabledResult < AWS::Type
  end

  class SetIdentityNotificationTopicResult < AWS::Type
  end

  class VerifyDomainDkimResult < AWS::Type
    array :DkimTokens
  end

  class VerifyDomainIdentityResult < AWS::Type
    field :VerificationToken
  end

  class VerifyEmailIdentityResult < AWS::Type
  end
end
