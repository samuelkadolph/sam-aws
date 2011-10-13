require "active_support/core_ext/hash/keys"
require "erb"
require "rails"
require "yaml"

module SES
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "sam-ses.add_path", before: "sam-ses.add_delivery_method" do |app|
        app.paths.add "config/mail", with: "config/mail.yml"
      end

      initializer "sam-ses.add_delivery_method", before: "action_mailer.set_configs" do |app|
        unless configuration = mail_configuration(app.paths["config/mail"].first)[::Rails.env]
          raise "#{::Rails.env} mail is not configured"
        end

        ActiveSupport.on_load(:action_mailer) do
          add_delivery_method :ses, SES::Courier, configuration.symbolize_keys
        end

        app.config.action_mailer.delivery_method = :ses
      end

      def mail_configuration(path)
        YAML.load(ERB.new(IO.read(path)).result)
      end
    end
  end
end
