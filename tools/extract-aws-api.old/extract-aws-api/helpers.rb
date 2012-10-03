require "fileutils"
require "nokogiri"
require "open-uri"
require "open-uri/cached"
require "yaml" # open-uri-cached needs this

module FileHelpers
  def chdir(*parts, &block)
    name = File.join(*parts)
    FileUtils.mkdir_p(name)
    Dir.chdir(name, &block)
  end

  def file(name, generator = nil, &block)
    File.open(name, "w") do |file|
      if generator
        file << generator
      else
        file.instance_exec(&block)
      end
    end
  end
end

module WebHelpers
  def retrieve(uri)
    Nokogiri.HTML(open(uri))
  rescue OpenURI::HTTPError => e
    puts "#{e} #{uri}"
    exit -1
  end
end
