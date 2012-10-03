require File.expand_path("../../.gemspec", __FILE__)

gemspec "s3-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-s3", AWS::VERSION
end
