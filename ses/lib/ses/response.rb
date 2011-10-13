require "aws/response"

module SES
  class Response < AWS::MetadataResponse
    class << self
      private
        def get_send_quota_result
          field :max24_hour_send, Float
          field :max_send_rate, Float
          field :sent_last24_hours, Float
        end

        def get_send_statistics_result
          array :send_data_points, :points do
            send_data_point
          end
        end

        def list_verified_email_addresses_result
          array :verified_email_addresses, :addresses
        end

        def send_data_point
          field :bounces, Bignum
          field :complaints, Bignum
          field :delivery_attempts, Bignum
          field :rejects, Bignum
          field :timestamp, DateTime
        end

        def send_email_result
          field :message_id, :id
        end

        alias send_raw_email_result send_email_result
    end
  end
end
