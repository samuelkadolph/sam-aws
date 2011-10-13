require "aws/response"

module EBS
  AWS::ABSTRACT_RESPONSES << "EBS::Response"

  class Response < AWS::MetadataResponse
    class << self
      private
        def application_description
          field :application_name
          array :configuration_templates
          field :date_created, DateTime
          field :date_updated, DateTime
          field :description
          array :versions
        end

        def application_version_description
          field :application_name
          field :date_created, DateTime
          field :date_updated, DateTime
          field :description
          struct :source_bundle do
            s3_location
          end
          field :version_label
        end

        def auto_scaling_group
          field :name
        end

        def check_dns_availability_result
          field :available, :boolean
          field :fully_qualified_cname
        end

        def configuration_option_description
          field :change_severity, %W[NoInterruption RestartEnvironment RestartApplicationServer]
          field :default_value
          field :max_length, Fixnum
          field :max_value, Fixnum
          field :min_value, Fixnum
          field :name
          field :namespace
          struct :regex do
            option_restriction_regex
          end
          field :user_defined, :boolean
          array :value_options
          field :value_type, %W[Boolean List Scalar]
        end

        def configuration_option_setting
          field :namespace
          field :option_name
          field :value
        end

        def configuration_settings_description
          field :application_name
          field :date_created, DateTime
          field :date_updated, DateTime
          field :deployment_status, %W[deployed failed pending]
          field :description
          field :environment_name
          array :option_settings do
            configuration_option_setting
          end
          field :solution_stack_name
          field :template_name
        end

        def create_application_result
          struct :application do
            application_description
          end
        end

        def create_application_version_result
          struct :application_version do
            application_version_description
          end
        end

        def create_configuration_template_result
          configuration_settings_description
        end

        def create_environment_result
          environment_description
        end

        def create_storage_location_result
          field :s3_bucket
        end

        def describe_application_versions_result
          array :application_versions do
            application_version_description
          end
        end

        def describe_applications_result
          array :applications do
            application_description
          end
        end

        def describe_configuration_options_result
          array :options do
            configuration_option_description
          end
          field :solution_stack_name
        end

        def describe_configuration_settings_result
          array :configuration_settings do
            configuration_settings_description
          end
        end

        def describe_environment_resources_result
          array :environment_resources do
            environment_resource_description
          end
        end

        def describe_environments_result
          array :environments do
            environment_description
          end
        end

        def describe_events_result
          array :events do
            event_description
          end
          field :next_token
        end

        def environment_description
          field :application_name
          field :cname
          field :date_created, DateTime
          field :date_updated, DateTime
          field :description
          field :endpoint_url
          field :environment_id
          field :environment_name
          field :health, %W[Green Grey Red Yellow]
          struct :resources do
            environment_resources_description
          end
          field :solution_stack_name
          field :status, %W[Launching Ready Terminated Terminating Updating]
          field :template_name
          field :version_label
        end

        def environment_info_description
          field :ec2_instance_id
          field :info_type, %W[tail]
          field :message
          field :sample_timestamp, DateTime
        end

        def environment_resource_description
          array :auto_scaling_groups do
            auto_scaling_group
          end
          field :environment_name
          array :instances do
            instance
          end
          array :launch_configurations do
            launch_configuration
          end
          array :load_balancers do
            load_balancer
          end
          array :triggers do
            trigger
          end
        end

        def environment_resources_description
          struct :load_balancer do
            load_balancer_description
          end
        end

        def event_description
          field :application_name
          field :environment_name
          field :event_date, DateTime
          field :message
          field :request_id
          field :severity, %W[TRACE DEBUG INFO WARN ERROR FATAL]
          field :template_name
          field :version_label
        end

        def instance
          field :id
        end

        def launch_configuration
          field :name
        end

        def list_available_solution_stacks_result
          array :solution_stack_details do
            solution_stack_description
          end
          array :solution_stacks
        end

        def listener
          field :port, Fixnum
          field :protocol
        end

        def load_balancer
          field :name
        end

        def load_balancer_description
          field :domain
          array :listeners do
            listener
          end
          field :load_balancer_name
        end

        def option_restriction_regex
          field :label
          field :pattern
        end

        def option_specification
          field :namespace
          field :option_name
        end

        def retrieve_environment_info_result
          struct :environment_info do
            environment_info_description
          end
        end

        def s3_location
          field :s3_bucket
          field :s3_key
        end

        def solution_stack_description
          array :permitted_file_types
          field :solution_stack_name
        end

        def source_configuration
          field :application_name
          field :template_name
        end

        def terminate_environment_result
          environment_description
        end

        def trigger
          field :name
        end

        def update_application_result
          struct :application do
            application_description
          end
        end

        def update_application_version_result
          struct :application_version do
            application_version_description
          end
        end

        def update_configuration_template_result
          configuration_settings_description
        end

        def update_environment_result
          environment_description
        end

        def validate_configuration_settings_result
          array :messages do
            validation_message
          end
        end

        def validation_message
          field :message
          field :namespace
          field :option_name
          field :severity, %W[error warning]
        end
    end
  end
end
