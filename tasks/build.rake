require "bundler/gem_helper"

class GemHelper < Bundler::GemHelper
  def install(options = {})
    dependencies = install_dependencies(options)
    without = Array(options[:without]) || []

    unless without.include?("build")
      desc "Build #{name}-#{version}.gem into the pkg directory"
      task :build => dependencies.map { |d| "#{d}:build" } do
        build_gem
      end
    end

    unless without.include?("install")
      desc "Build and install #{name}-#{version}.gem into system gems"
      task :install => dependencies.map { |d| "#{d}:install" } do
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
  end

  def install_dependencies(options = {})
  end
end

def install_dependencies_task(*dependencies)
  p dependencies
  dependencies.each do |dependency|
    p dependency.runtime_dependencies
  end
  # puts "dependency: #{dependency.inspect}"
  # puts " - #{dependency.runtime_dependencies.inspect}"
end

helper = GemHelper.new(Dir.pwd)
# require "pry"; Pry.start(binding)
helper.install
# install_dependencies_task(*helper.gemspec.runtime_dependencies)
# p helper.gemspec.runtime_dependencies
# GemHelper.new(Dir.pwd).install



# class Rake::Application
#   attr_reader :scope
# end

# scope = Rake.application.scope.map { |scope| scope.split(":") }.flatten
# root = File.expand_path("../..", __FILE__)

# if (scope.empty? && Dir.pwd == root) || scope == %W[aws]
#   GemHelper.new(root).install(without: "release")
# elsif scope.empty?
#   GemHelper.new(Dir.pwd).install
# else
#   GemHelper.new(File.join(root, scope.join("-"))).install(without: "release")
# end
