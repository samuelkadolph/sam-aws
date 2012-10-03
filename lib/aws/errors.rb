module AWS
  require "aws/error"

  # The request signature does not conform to AWS standards.
  class IncompleteSignatureError < APIError
  end

  # The request processing has failed due to some unknown error, exception or failure.
  class InternalFailureError < APIError
  end

  # The action or operation requested is invalid.
  class InvalidActionError < APIError
  end

  # The X.509 certificate or AWS Access Key ID provided does not exist in our records.
  class InvalidClientTokenIdError < APIError
  end

  # Parameters that must not be used together were used together.
  class InvalidParameterCombinationError < APIError
  end

  # A bad or out-of-range value was supplied for the input parameter.
  class InvalidParameterValueError < APIError
  end

  # AWS query string is malformed, does not adhere to AWS standards.
  class InvalidQueryParameterError < APIError
  end

  # The query string is malformed.
  class MalformedQueryStringError < APIError
  end

  # The request is missing an action or operation parameter.
  class MissingActionError < APIError
  end

  # Request must contain either a valid (registered) AWS Access Key ID or X.509 certificate.
  class MissingAuthenticationTokenError < APIError
  end

  # An input parameter that is mandatory for processing the request is not supplied.
  class MissingParameterError < APIError
  end

  # The AWS Access Key ID needs a subscription for the service.
  class OptInRequiredError < APIError
  end

  # Request is past expires date or the request date (either with 15 minute padding), or the request date occurs more than 15 minutes in the future.
  class RequestExpiredError < APIError
  end

  # The request has failed due to a temporary failure of the server.
  class ServiceUnavailableError < APIError
  end

  # Request was denied due to request throttling.
  class ThrottlingError < APIError
  end
end
