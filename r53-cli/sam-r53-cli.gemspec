require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "r53-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-r53", AWS::VERSION
end
