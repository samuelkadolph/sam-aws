require File.expand_path("../../.gemspec", __FILE__)

gemspec "rds-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-rds", AWS::VERSION
end
