EXECUTABLE_GEMS = GEMS.grep(/cli/)
LIBRARY_GEMS = GEMS - EXECUTABLE_GEMS

task "aws:cli:base:build" => "aws:build"
task "aws:cli:base:install" => "aws:install"

LIBRARY_GEMS.each do |name|
  task "#{name}:build" => "aws:build"
  task "#{name}:install" => "aws:install"
end

EXECUTABLE_GEMS.each do |name|
  parent = name.gsub(/:cli/, "")
  task "#{name}:build" => %W[aws:cli:base:build #{parent}:build]
  task "#{name}:install" => %W[aws:cli:base:install #{parent}:install]
  task "build" => "#{name}:build"
  task "install" => "#{name}:install"
end
