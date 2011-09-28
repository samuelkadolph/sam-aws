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
      string.delete("\\`").tr("\n", " ").to_s
    end
end

def readme(path = File.expand_path("./README.md"))
  (@readmes ||= {})[path] ||= Readme.new(path)
end

def gemspec(name)
  Gem::Specification.new do |s|
    s.name        = "sam-#{name}"
    s.version     = AWS::VERSION
    s.authors     = ["Samuel Kadolph"]
    s.email       = ["samuel@kadolph.com"]
    s.homepage    = "https://github.com/samuelkadolph/sam-aws" << (name == "aws" ? "" : "/tree/master/#{name}")
    s.summary     = readme.summary
    s.description = readme.description
    s.license     = "MIT"

    s.required_ruby_version = ">= 1.9.2"

    s.files       = Dir["bin/*", "lib/**/*", "LICENSE", "README.md"]
    s.test_files  = Dir["test/**/*_test.rb"]
    s.executables = Dir["bin/*"].map(&File.method(:basename))

    yield s if block_given?
  end
end
