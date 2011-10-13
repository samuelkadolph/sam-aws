require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "r53" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
