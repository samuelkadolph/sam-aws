require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "ebs-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-ebs", AWS::VERSION
end
