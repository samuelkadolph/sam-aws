require "active_support/concern"

module AWS
  module Encoding
    require "aws/encoding/form_data"
    require "aws/encoding/form_url"
    require "aws/encoding/url"

    extend ActiveSupport::Concern

    include FormData
    include FormURL
    include URL
  end
end
