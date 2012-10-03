require File.expand_path("../../.gemspec", __FILE__)

gemspec "aws-cli-base" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
  # s.add_dependency "proxifier", "~> 1.0.2"
  s.add_dependency "thor", "0.14.6"
end
