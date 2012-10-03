require "aws/errors"

module EBS
  # APIError class for EBS.
  class APIError < AWS::APIError
  end

  # The caller does not have a subscription to Amazon S3.
  class S3SubscriptionRequiredError < APIError
  end

  # Unable to delete the Amazon S3 source bundle associated with theapplication version, although the application version deleted successfully.
  class SourceBundleDeletionError < APIError
  end

  # The caller has exceeded the limit on the number of application versions associated with their account.
  class TooManyApplicationVersionsError < APIError
  end

  # The caller has exceeded the limit on the number of applications associated with their account.
  class TooManyApplicationsError < APIError
  end

  # The web service attempted to create a bucket in an Amazon S3 account that already has 100 buckets.
  class TooManyBucketsError < APIError
  end

  # The caller has exceeded the limit on the number of configuration templates associated with their account.
  class TooManyConfigurationTemplatesError < APIError
  end

  # The caller has exceeded the limit of allowed environments associated with the account.
  class TooManyEnvironmentsError < APIError
  end
end
