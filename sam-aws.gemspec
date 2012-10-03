require File.expand_path("../.gemspec", __FILE__)

gemspec "aws" do |gem|
  gem.add_dependency "activesupport", "~> 3.2.8"
  gem.add_dependency "net-http-persistent", "~> 2.1"
  gem.add_dependency "nokogiri", "~> 1.5.5"

  if RUBY_ENGINE == "jruby"
    gem.platform = "jruby"
    gem.add_dependency "jruby-openssl"
  end
end
