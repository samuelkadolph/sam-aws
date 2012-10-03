require "bundler/gem_helper"

class GemHelper < Bundler::GemHelper
   def install(options = {})
    without = Array(options[:without]) || []

    unless without.include?("build")
      desc "Build #{name}-#{version}.gem into the pkg directory"
      task :build do
        build_gem
      end
    end

    unless without.include?("install")
      desc "Build and install #{name}-#{version}.gem into system gems"
      task :install do
        install_gem
      end
    end

    unless without.include?("release")
      desc "Build and push #{name}-#{version}.gem to Rubygems"
      task :release do
        guard_clean
        built_gem_path = build_gem
        rubygem_push(built_gem_path)
      end
    end

    GemHelper.instance = self
  end
end

class Rake::Application
  attr_reader :scope
end

scope = Rake.application.scope.map { |scope| scope.split(":") }.flatten
root = File.expand_path("../..", __FILE__)

if (scope.empty? && Dir.pwd == root) || scope == %W[aws]
  GemHelper.new(root).install(without: "release")
elsif scope.empty?
  GemHelper.new(Dir.pwd).install
else
  GemHelper.new(File.join(root, scope.join("-"))).install(without: "release")
end
