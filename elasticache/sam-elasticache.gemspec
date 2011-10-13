require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "elasticache" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
