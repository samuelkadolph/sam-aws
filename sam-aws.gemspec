require File.expand_path("../.gemspec_helper", __FILE__)

gemspec "aws" do |s|
  s.add_dependency "net-http-persistent", "~> 2.1"
  s.add_dependency "nokogiri", "~> 1.5.0"
end
