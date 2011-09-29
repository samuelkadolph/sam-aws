require File.expand_path("../../.gemspec_helper", __FILE__)

gemspec "aws-cli" do |s|
  s.add_dependency "sam-aws-cli-base", AWS::VERSION
  s.add_dependency "sam-ebs-cli", AWS::VERSION
  s.add_dependency "sam-ec2-cli", AWS::VERSION
  s.add_dependency "sam-elb-cli", AWS::VERSION
  s.add_dependency "sam-rds-cli", AWS::VERSION
  s.add_dependency "sam-s3-cli", AWS::VERSION
end
