require "securerandom"

module R53
  class Account < AWS::Account
    require "r53/account/xml"

    include AWS::Account::Endpoint
    include AWS::Account::VersionInPath
    include XML

    DEFAULT_OPTIONS = {
      authenticator: AWS::S3HTTPSAuthenticator,
      endpoint: "https://route53.amazonaws.com"
    }
    VERSION = "2011-05-05"
    XMLNS = "https://route53.amazonaws.com/doc/2011-05-05/"

    def change_resource_record_sets(id, changes, options = {})
      post prefix("/hostedzone", "#{id}/rrset") do |body|
        body.xml(&change_resource_record_sets_xml)
      end
    end
    bang :change_resource_record_sets

    def create_hosted_zone(name, options = {})
      options[:reference] ||= SecureRandom.hex

      post "/hostedzone" do |body|
        body.xml(&create_hosted_zone_xml(name, options))
      end
    end
    bang :create_hosted_zone

    def delete_hosted_zone(id)
      delete prefix("/hostedzone", id)
    end
    bang :delete_hosted_zone

    def get_change(id)
      get prefix("/change", id)
    end
    bang :get_change

    def get_hosted_zone(id)
      get prefix("/hostedzone", id)
    end
    bang :get_hosted_zone

    def list_hosted_zones(options = {})
      get "/hostedzone" do |query|
        query.add_option("marker", options[:marker])
        query.add_option("maxitems", options[:max_items])
      end
    end
    bang :list_hosted_zones
    # all :list_hosted_zones, :DescribeDBInstancesResult do
    #
    # end

    def list_all_hosted_zones!(options = {})
      zones = []
      response = list_hosted_zones!(options)
      zones.concat(response.HostedZones)

      while response.IsTruncated?
        options[:marker] = response.NextMarker

        response = list_hosted_zones!(options)
        zones.concat(response.HostedZones)
      end

      zones
    end

    def list_resource_record_sets(id, options = {})
      get prefix("/hostedzone", "#{id}/rrset") do |query|
        query.add_option("identifier", options[:identifier])
        query.add_option("maxitems", options[:max_items])
        query.add_option("name", options[:name])
        query.add_option("type", options[:type])
      end
    end
    bang :list_resource_record_sets

    def list_all_resource_record_sets!(id, options = {})
      sets = []
      response = list_resource_record_sets!(id, options)
      sets.concat(response.ResourceRecordSets)

      while response.IsTruncated?
        options[:identifier] = response.NextRecordIdentifier if response.NextRecordIdentifier
        options[:name] = response.NextRecordName
        options[:type] = response.NextRecordType

        response = list_resource_record_sets!(id, options)
        sets.concat(response.ResourceRecordSets)
      end

      sets
    end

    private
      def prefix(prefix, path)
        result =  ""
        result << prefix unless path.start_with?(prefix)
        result << "/" unless path.start_with?("/")
        result << path
        result
      end
  end
end
