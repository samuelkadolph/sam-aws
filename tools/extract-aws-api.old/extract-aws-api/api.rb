require "active_support/core_ext/string/inflections"
require "ext"
require "helpers"

class API
  include WebHelpers

  attr_reader :name

  def initialize(name, module_name = nil, uri = nil)
    @name, @module_name, @uri = name, module_name, uri
  end

  def actions
    @actions ||= Action.all(self, toc.actions)
  end

  def common_errors
    @errors ||= CommonError.all(retrieve(uri + "CommonErrors.html"))
  end

  def data_types
    @data_types ||= DataType.all(self, toc.data_types)
  end

  def data_type_for(type)
    data_types.each do |data_type|
      return data_type if data_type.name == type.name
    end

    raise "could not find a DataType for #{type.name}"
  end

  def dir
    module_name.downcase
  end

  def endpoint
    return @endpoint if defined?(@endpoint)

    endpoints = regions_and_endpoints.select do |endpoint|
      endpoint =~ /(#{name}|#{dir})\./i
    end

    if endpoints.empty?
      raise "no endpoint found for #{name}"
    elsif endpoints.size == 1 and not endpoints.first =~ /us-east-1/
      endpoint, region = endpoints.first, nil
    else
      endpoint, region = endpoints.first.gsub(/(us-east-1)/, "%s"), $1
    end

    @endpoint, @region = "https://#{endpoint}", region
    @endpoint
  end

  def endpoint?
    !!endpoint
  end

  def errors
    actions.map(&:errors).flatten.uniq.sort
  end

  def errors?
    actions.any?(&:errors?)
  end

  def file
    "#{dir}.rb"
  end

  def module_name
    @module_name ||= name.gsub(/(AWS|Amazon|Elastic)/, "")
  end
  alias mod module_name

  def region
    endpoint # force endpoint retrieval
    @region
  end

  def region?
    !!region
  end

  def toc
    @toc ||= TOC.new(self)
  end

  def uri
    @uri ||= URI("http://docs.amazonwebservices.com/#{name}/latest/APIReference/")
  end

  def version
    @version ||= retrieve(uri + "_title.html").css("#gd").extract(/API Reference \(API Version (.*)\)/)
  end

  def version?
    !!version
  end

  private
    def regions_and_endpoints
      @regions_and_endpoints ||= begin
        document = retrieve("http://docs.amazonwebservices.com/general/latest/gr/rande.html")
        document.css(".section").map do |element|
          if table = element.css(".informaltable").first
            table.xpath("table/tbody/tr/td[2]").map(&:extract)
          elsif element.css(".titlepage h2").extract != "Overview"
            element.css("p").extract(/(\w+\.amazonaws\.com)/)
          else
            []
          end
        end.flatten
      end
    end

  class Base
    include Comparable
    include WebHelpers
    extend WebHelpers

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def <=>(other)
      name <=> other.name
    end

    def ==(other)
      self.class == other and name == other.name or name == other
    end

    def eql?(other)
      self.class === other and name.eql?(other.name)
    end

    def hash
      name.hash
    end
  end

  class Action < Base
    class << self
      def all(api, entries)
        entries.map { |entry| parse(api, entry, retrieve(api.uri + entry.page)) }
      end

      def parse(api, entry, document)
        name = entry.name
        if section = document.sections(/Description/)
          description = section.css("p")[0].extract
        else
          raise "could not find description for #{name}"
        end

        new(api, name, description, Parameter.all(document), Response.extract(document), Error.all(document))
      end
    end

    attr_reader :api, :description, :parameters, :response, :errors

    def initialize(api, name, description, parameters, response, errors)
      super(name)
      @api, @description, @parameters, @response, @errors = api, description, parameters, response, errors
    end

    def all_errors
      api.common_errors + errors
    end

    def errors?
      !errors.empty?
    end

    def response?
      !!response
    end
  end

  class DataType < Base
    class << self
      def all(api, entries)
        entries.map { |entry| parse(api, entry, retrieve(api.uri + entry.page)) }
      end

      def parse(api, entry, document)
        name = entry.name
        if section = document.sections(/Description/)
          description = section.css("p")[0].extract
        else
          raise "could not find description for #{name}"
        end

        new(api, name, description, Parameter.all(document, /Contents/))
      end
    end

    attr_reader :api, :description, :parameters

    def initialize(api, name, description, parameters)
      super(name)
      @api, @description, @parameters = api, description, parameters
    end
  end

  class Error < Base
    class << self
      def all(document)
        if section = document.sections(/Errors/)
          return section.xpath("div/table/tbody/tr").map { |row| parse(*row.xpath("td")) }
        else
          []
        end
      end

      def parse(name, description, status, *)
        new(name.extract, description.extract, status.extract)
      end
    end

    attr_reader :description, :status

    def initialize(name, description, status)
      super(name)
      @description, @status = description, status
    end

    def to_s
      "#{name}Error"
    end
  end

  class CommonError < Error
    class << self
      def all(document)
        document.css("#CommonErrors").xpath("div/table/tbody/tr").map { |row| parse(*row.xpath("td")) }
      end
    end

    def to_s
      "AWS::#{super}"
    end
  end

  class Parameter < Base
    class << self
      def all(document, regexp = /Parameters/)
        if section = document.sections(regexp)
          return section.xpath("div/table/tbody/tr").map { |row| parse(*row.xpath("td")) }
        else
          []
        end
      end

      def parse(first, second, third = nil, *)
        name = first.extract
        description = second.css("p")[0].extract
        type = second.css("p.simpara")[0].extract(/^Type: (.*)/)
        required = third ? third.extract =~ /Yes/ : false

        if second.css("p").find { |e| e.extract =~ /^Default: (.*)$/ }
          default = $1
        end

        new(name, description, default, type, required)
      end
    end

    attr_reader :description, :default, :type, :required

    def initialize(name, description, default, type, required)
      super(name)
      @description, @default, @type, @required = description, default, Type.new(type), required
    end

    def default?
      !!default
    end

    def name
      type.array? ? @name.gsub(".member.N", "") : @name
    end

    def required?
      !!required
    end
  end

  class Response
    class << self
      def extract(document)
        if section = document.sections(/Response/)
          parse(section.css("code")[0].extract, section.xpath("div/table/tbody/tr"))
        else
          nil
        end
      end

      def parse(wrapper, contents_rows)
        contents = {}

        contents_rows.each do |row|
          name, description, * = row.xpath("td")
          contents[name.extract] = description.extract_type
        end

        new(wrapper, contents)
      end
    end

    attr_reader :wrapper, :contents

    def initialize(wrapper, contents)
      @wrapper, @contents = wrapper, contents
    end

    def wrapper?
      !!wrapper
    end
  end

  class TOC
    include WebHelpers

    attr_reader :api

    def initialize(api)
      @api = api
    end

    def actions
      @actions ||= extract("#API_Operations a")
    end

    def data_types
      @data_types ||= extract("#API_Types a")
    end

    private
      def document
        @document ||= retrieve(api.uri + "_toc.html")
      end

      def extract(selector)
        document.css(selector).map { |e| Entry.new(e.extract, e["href"]) }.sort
      end

    class Entry
      include Comparable

      attr_reader :name, :page

      def initialize(name, page)
        @name, @page = name, page
      end

      def <=>(other)
        name <=> other.name
      end
    end
  end

  class Type < Base
    attr_reader :array
    alias array? array

    def initialize(raw)
      if raw =~ /(.*) list$/
        @name, @array = $1.singularize, true
      else
        @name, @array = raw, false
      end
    end

    def builtin?
      %W[String Integer Boolean DateTime].include?(name)
    end

    def custom?
      !builtin?
    end
  end
end
