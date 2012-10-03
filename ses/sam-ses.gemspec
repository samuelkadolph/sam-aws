require File.expand_path("../../.gemspec", __FILE__)

gemspec "ses" do |gem|
  gem.add_dependency "sam-aws", AWS::VERSION
end
