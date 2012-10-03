require File.expand_path("../../.gemspec", __FILE__)

gemspec "s3" do |s|
  s.add_dependency "sam-aws", AWS::VERSION
end
