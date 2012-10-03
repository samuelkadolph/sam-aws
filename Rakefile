GEMS = %W[ebs ebs:cli ec2 ec2:cli elasticache elasticache:cli elb elb:cli r53 r53:cli rds rds:cli s3 s3:cli ses ses:cli]
DIRS = GEMS.map { |name| name.tr(":", "-") }

load "tasks/build.rake"
(%W[aws:cli aws:cli:base] + GEMS).each { |name| namespace(name) { load "tasks/build.rake" } }
load "tasks/build/dependencies.rake"

namespace "build" do
  desc "Build gems into the each gem's pkg directory"
  task "all" => %W[build aws:cli:build aws:cli:base:build] + GEMS.map { |name| "#{name}:build" }
end
namespace "install" do
  desc "Build and install each gem into system gems"
  task "all" => %W[install aws:cli:install aws:cli:base:install] + GEMS.map { |name| "#{name}:install" }
end

helper = Bundler::GemHelper.new(Dir.pwd)
desc "Create tag #{helper.send(:version_tag)} and build and push each gem to Rubygems"
task "release" do
  helper.send(:guard_clean)
  helper.send(:guard_already_tagged)
  built_gem_path = helper.send(:build_gem)
  helper.send(:tag_version) do
    helper.send(:git_push)
    helper.send(:rubygem_push, built_gem_path)
    (%W[aws:cli:release aws:cli:base:release] + GEMS.map { |name| "#{name}:release" }).each do |task|
      Rake::Task[task].invoke
    end
  end
end
