require "aws/response"

module SES
  class DeleteVerifiedEmailAddressResponse < Response
  end

  class GetSendQuotaResponse < Response
    struct :get_send_quota_result do
      get_send_quota_result
    end
  end

  class GetSendStatisticsResponse < Response
    struct :get_send_statistics_result do
      get_send_statistics_result
    end
  end

  class ListVerifiedEmailAddressesResponse < Response
    struct :list_verified_email_addresses_result do
      list_verified_email_addresses_result
    end
  end

  class SendEmailResponse < Response
    struct :send_email_result do
      send_email_result
    end
  end

  class SendRawEmailResponse < Response
    struct :send_raw_email_result do
      send_raw_email_result
    end
  end

  class VerifyEmailAddressResponse < Response
  end
end
