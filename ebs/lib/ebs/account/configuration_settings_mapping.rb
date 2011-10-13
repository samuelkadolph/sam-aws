module EBS
  class Account
    module ConfigurationSettingsMapping
      MAPPINGS = {
        JDBC: { namespace: "aws:elasticbeanstalk:application:environment", name: "JDBC_CONNECTION_STRING" },
        PARAM1: { namespace: "aws:elasticbeanstalk:application:environment", name: "PARAM1" },
        PARAM2: { namespace: "aws:elasticbeanstalk:application:environment", name: "PARAM2" },
        PARAM3: { namespace: "aws:elasticbeanstalk:application:environment", name: "PARAM3" },
        PARAM4: { namespace: "aws:elasticbeanstalk:application:environment", name: "PARAM4" },
        PARAM5: { namespace: "aws:elasticbeanstalk:application:environment", name: "PARAM5" },
        key: { namespace: "aws:autoscaling:launchconfiguration", name: "EC2KeyName" },
        type: { namespace: "aws:autoscaling:launchconfiguration", name: "InstanceType" }
      }

      def map_configuration_settings(options)
        settings = []

        options.each do |key, value|
          next unless mapping = MAPPINGS[key.to_sym]
          settings << { "Namespace" => mapping[:namespace], "OptionName" => mapping[:name], "Value" => value}
        end

        settings
      end
    end
  end
end
