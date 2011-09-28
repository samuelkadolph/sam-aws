require "uri"

module AWS
  class Request
    require "aws/request/headers"
    require "aws/request/methods"
    require "aws/request/query"

    attr_accessor :headers, :host, :method, :path, :query, :scheme

    def initialize(uri, method = :get, headers = {})
      uri = URI(uri)
      self.headers = Headers.new(headers)
      self.host = uri.host
      self.method = method
      self.path = uri.path
      self.query = Query.new(uri.query)
      self.scheme = uri.scheme
    end

    def initialize_clone(other)
      self.host = other.host.clone if other.host
      self.method = other.method.clone if other.method
      self.path = other.path.clone if other.path
      self.query = other.query.clone if other.query
      self.scheme = other.scheme.clone if other.scheme
    end
    alias initialize_dup initialize_clone

    def method=(method)
      @method = @@methods[method.to_s.upcase]
    end

    def path=(path)
      path = "" unless path
      path.insert(0, "/") unless path[0] == "/"
      @path = path
    end

    def uri
      URI("#{scheme}://#{host}") + path + "?#{query}"
    end
  end
end
