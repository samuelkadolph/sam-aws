require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "ec2" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
