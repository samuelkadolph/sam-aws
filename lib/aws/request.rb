require "uri"

module AWS
  class Request
    require "aws/request/headers"
    require "aws/request/methods"
    require "aws/request/params"
    require "aws/request/query"

    MAXIMUM_REQUEST_URI_LENGTH = 4096

    attr_accessor :body, :headers, :host, :method, :params, :path, :query, :scheme

    def initialize(method, uri, params = {}, query = {}, body = nil, headers = {})
      uri = URI(uri) unless uri.is_a?(URI)

      self.body = body
      self.headers = Headers.new(headers)
      self.host = uri.host
      self.method = method
      self.params = Params.new(params)
      self.path = uri.path
      self.query = Query.new(uri.query)
      self.query.merge!(query) if query
      self.scheme = uri.scheme
    end

    def initialize_clone(other)
      self.body = other.body.clone if other.body
      self.host = other.host.clone if other.host
      self.method = other.real_method if other.method
      self.params = other.params.clone if other.params
      self.path = other.path.clone if other.path
      self.query = other.query.clone if other.query
      self.scheme = other.scheme.clone if other.scheme
    end
    alias initialize_dup initialize_clone

    def auto
      self.clone.tap do |request|
        if too_big_for_get?
          request.body = params.to_form_url_encoded
          request.headers["Content-Type"] = "application/x-www-form-urlencoded"
          request.method = :post
          request.params.clear
        else
          request.method = :get
          request.query.merge!(request.params)
          request.params.clear
        end
      end
    end

    def auto?
      real_method == :auto
    end

    def auto_method
      if too_big_for_get?
        PostMethod.new
      else
        GetMethod.new
      end
    end

    alias real_method method
    def method
      if real_method == :auto
        auto_method
      else
        real_method
      end
    end

    def method=(method)
      if method == :auto
        @method = :auto
      elsif method.is_a?(Method)
        @method = method
      elsif method.is_a?(Class) and method < Method
        @method = method.new
      elsif klass = @@methods[method]
        @method = klass.new
      else
        raise ArgumentError, "unknown method #{method}"
      end
    end

    def path=(path)
      path = "" unless path
      path.insert(0, "/") unless path[0] == "/"
      @path = path
    end

    def perform(pool, &block)
      if auto?
        auto.perform(pool, &block)
      else
        warn "params are only supported for auto method requests" unless params.empty?
        pool.connection_for(uri).request(method.klass.new(uri.request_uri, headers), body, &block)
      end
    end

    def query_string
      q = query.clone
      q.merge!(params) if auto? && params && !params.empty?
      q.empty? ? "" : q.to_s
    end

    def too_big_for_get?
      uri.request_uri.size > MAXIMUM_REQUEST_URI_LENGTH
    end

    def uri
      URI("#{scheme}://#{host}") + path + "?#{query_string}"
    end

    # TODO: find a better name
    def wrapper
      auto? ? auto : self
    end
  end
end

