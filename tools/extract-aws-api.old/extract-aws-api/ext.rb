require "nokogiri"

class Array
  def comment
    map(&:comment)
  end

  def comment!
    each(&:comment!)
  end

#   def indent(n = 2, separator = "\n")
#     map { |item| item.to_s.chomp }.join(separator).indent(n)
#   end
end

class String
  def comment
    dup.comment!
  end

  def comment!
    gsub!(/^/, "# ")
  end

  def indent(n = 2)
    dup.indent!(n)
  end

  def indent!(n = 2)
    gsub!(/^(.)/, " " * n << "\\1")
  end
end

module Extract
  def extract(regexp = nil)
    text = self.text.strip.delete("\n\t").squeeze(" ")
    text = text =~ regexp && $1 if regexp
    text
  end

  def extract_type
    type = css("p.simpara")[0].extract(/^Type: (.*)/)

    if type =~ /(.*) list/
      type = "Array<#{$1}>"
    elsif css("p").extract =~ /A list of/
      type = "Array<#{type}>"
    end

    type
  end

  Nokogiri::XML::Node.send(:include, self)
  Nokogiri::XML::NodeSet.send(:include, self)
end

module Sections
  def sections(find = nil)
    sections = xpath %Q{/html/body/div[@class="section"]/div[@class="section"]}

    if find
      sections.find { |section| section.xpath(%Q{div[@class="titlepage"]}).text =~ find }
    else
      sections
    end
  end

  Nokogiri::HTML::Document.send(:include, self)
end
