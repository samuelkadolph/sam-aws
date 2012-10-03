require File.expand_path("../../.gemspec", __FILE__)

gemspec "rds" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
