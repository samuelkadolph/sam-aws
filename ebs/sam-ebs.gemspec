require File.expand_path("../../.gemspec", __FILE__)

gemspec "ebs" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
