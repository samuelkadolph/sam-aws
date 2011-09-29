EXECUTABLE_GEMS = GEMS.grep(/cli/)
LIBRARY_GEMS = GEMS - EXECUTABLE_GEMS

task "aws:cli:base:build" => "build"
task "aws:cli:base:install" => "install"

LIBRARY_GEMS.each do |name|
  task "#{name}:build" => "build"
  task "#{name}:install" => "install"
end

EXECUTABLE_GEMS.zip(LIBRARY_GEMS).each do |name, library|
  task "#{name}:build" => %W[aws:cli:base:build #{library}:build]
  task "#{name}:install" => %W[aws:cli:base:install #{library}:install]
  task "aws:cli:build" => "#{name}:build"
  task "aws:cli:install" => "#{name}:install"
end
