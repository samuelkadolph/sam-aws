# sam-ses

sam-ses is a library for interacting with Amazon's Simple Email Service.

## Description

DESC

## Usage

### API

```ruby
require "ses"

account = SES::Account.new(access_key: "022QF06E7MXBSH9DHM02", secret_key: "kWcrlUX5JEDGM/LtmEENI/aVmYvHNif5zB+d9+ct")

account.get_send_quota!.GetSendQuotaResult # => #<struct Max24HourSend="200.0", MaxSendRate="1.0", SentLast24Hours="2.0">
account.send_email!("from@example.com", "Subject", "Body", html: "<b>Hi!</b>")

require "base64"
require "mail"

mail = Mail.new do
  from    "from@example.com"
  to      "someone@example.com"
  subject "Hello"
  body    "Hello! Thanks."
end

account.send_raw_email!(Base64.encode64(mail.to_s))
```

### Courier

```ruby
require "ses"
require "mail"

mail = Mail.new do
  from    "from@example.com"
  to      "someone@example.com"
  subject "Hello"
  body    "Hello! Thanks."
end

courier = SES::Courier.new(access_key: "022QF06E7MXBSH9DHM02", secret_key: "kWcrlUX5JEDGM/LtmEENI/aVmYvHNif5zB+d9+ct")
courier.deliver(mail)
```

### Rails (Action Mailer)

Add the gem to your `Gemfile` and create a `config/mail.yml` file to store your access key and secret key for each
environment or restrict loading the gem to only a specific environment.

```ruby
group :production do
  gem "sam-ses", require: "ses/rails"
end
```

```ruby
production:
  access_key: 022QF06E7MXBSH9DHM02
  secret_key: kWcrlUX5JEDGM/LtmEENI/aVmYvHNif5zB+d9+ct
```
