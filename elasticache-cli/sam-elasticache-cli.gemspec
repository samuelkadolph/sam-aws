require File.expand_path("../../.gemspec", __FILE__)

gemspec "elasticache-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-elasticache", AWS::VERSION
end
