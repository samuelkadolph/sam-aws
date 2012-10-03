require File.expand_path("../lib/aws/version", __FILE__)

class Readme < String
  attr_reader :path

  def initialize(path)
    @path = path
    super(File.read(self.path))
  end

  def summary
    if self =~ /^# (?:\S+)\s+(.+?)\s{2,}/m
      scrub $1
    else
      raise "could not find summary in #{path}"
    end
  end

  def description
    if self =~ /^## Description\s+(.+?)\s{2,}/m
      scrub $1
    else
      raise "could not find description in #{path}"
    end
  end

  private
    def scrub(string)
      string.delete("\\`").gsub(/\[([^\]]+)\]\([^)]*\)/, "\\1").tr("\n", " ").to_s
    end
end

def readme(path = File.expand_path("./README.md"))
  (@readmes ||= {})[path] ||= Readme.new(path)
end

def gemspec(name)
  Gem::Specification.new do |gem|
    gem.name        = "sam-#{name}"
    gem.authors     = ["Samuel Kadolph"]
    gem.email       = ["samuel@kadolph.com"]
    gem.description = readme.description
    gem.summary     = readme.summary
    gem.license     = "MIT"
    gem.homepage    = "http://samuelkadolph.github.com/sam-aws/" << (name == "aws" ? "" : "#{name}/")
    gem.version     = AWS::VERSION

    gem.files       = Dir["bin/*", "etc/**/*", "lib/**/*"]
    gem.test_files  = Dir["test/**/*_test.rb"]
    gem.executables = Dir["bin/*"].map(&File.method(:basename))

    gem.required_ruby_version = ">= 1.9.2"

    gem.add_development_dependency "bundler", "~> 1.2.0"
    gem.add_development_dependency "mocha", "~> 0.12.4"
    gem.add_development_dependency "rake", "~> 0.9.2.2"

    yield gem if block_given?
  end
end
