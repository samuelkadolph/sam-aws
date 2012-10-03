require "pry"
require "uri"

$:.unshift(File.expand_path("../extract-aws-api", __FILE__))
require "api"
require "generators"
require "helpers"
require "inflections"

unless (1..3) === ARGV.size
  puts "usage: #{$0} NAME [MODNAME] [URI]"
  exit 1
end

module ExtractAWSAPI
  extend FileHelpers

  api = API.new(*ARGV)

  # preload
  api.toc
  api.version
  api.endpoint
  api.actions
  api.data_types

  chdir api.dir, "lib" do
    file api.file, Generators::Files::Main.new(api)

    chdir api.dir do
      file "account.rb", Generators::Files::Account.new(api)
      file "errors.rb", Generators::Files::Errors.new(api)
      file "responses.rb", Generators::Files::Responses.new(api)
      file "types.rb", Generators::Files::Types.new(api)
    end
  end

  chdir "#{api.dir}-cli" do
    chdir "bin" do
      file api.dir, Generators::Files::CLI::Bin.new(api)
    end

    chdir "lib", api.dir do
      file "cli.rb", Generators::Files::CLI::Main.new(api)
    end
  end
end
