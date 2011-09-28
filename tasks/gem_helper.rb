require "bundler/gem_helper"

module Bundler
  class GemHelper
    def self.install_master_tasks(opts = {})
      dir = opts[:dir] || Dir.pwd
      self.new(dir, opts[:name]).install_master
    end

    def self.install_sub_tasks(opts = {})
      dir = opts[:dir] || Dir.pwd
      self.new(dir, opts[:name]).install_sub
    end

    def install_master
      desc "Build #{name}-#{version}.gem into the pkg directory"
      task 'build' do
        build_gem
      end

      desc "Build and install #{name}-#{version}.gem into system gems"
      task 'install' do
        install_gem
      end
    end

    def install_sub
      desc "Build #{name}-#{version}.gem into the pkg directory"
      task 'build' do
        build_gem
      end

      desc "Build and install #{name}-#{version}.gem into system gems"
      task 'install' do
        install_gem
      end

      desc "Build and push #{name}-#{version}.gem to Rubygems"
      task 'release' do
        built_gem_path = build_gem
        rubygem_push(built_gem_path)
      end
    end
  end
end
