require "fileutils"
require "nokogiri"
require "open-uri"
require "open-uri/cached"
# require "yaml"

module Helper
  def chdir(*parts, &block)
    name = File.join(*parts)
    FileUtils.mkdir_p(name)
    Dir.chdir(name, &block)
  end

  def file(name, generator = nil)
    File.open(name, "w") do |file|
      if generator
        file << generator
      else
        yield file
      end
    end
  end

  def retrieve(uri)
    Nokogiri.HTML(open(uri))
  rescue OpenURI::HTTPError => e
    puts "#{e} #{uri}"
    exit -1
  end
end
