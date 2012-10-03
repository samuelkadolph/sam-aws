require File.expand_path("../../.gemspec", __FILE__)

gemspec "ec2-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-ec2", AWS::VERSION
end
