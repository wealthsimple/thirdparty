module Thirdparty
  class Request
    attr_reader :method, :path, :body, :authenticated

    def initialize(method:, path:, body: nil, authenticated: true)
      Thirdparty.configuration.validate!
      @method = method
      path = "/#{path}" unless path.start_with?("/")
      @path = path
      @body = body
      @authenticated = authenticated
    end

    %i(get post put delete head patch).each do |http_method|
      define_singleton_method(http_method) do |path, body: nil, authenticated: nil|
        Request.new(method: http_method, path: path, body: body, authenticated: authenticated).execute
      end
    end

    def execute
      connection.send(method) do |request|
        request.url path
        headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/json",
        }
        if authenticated
          headers["Authorization"] = "Bearer #{Oauth.access_token}"
        end
        request.headers.merge!(headers)
        request.body = body_to_json(body)
        request
      end
    end

  private

    def connection
      Faraday.new(url: Thirdparty.configuration.base_url) do |faraday|
        faraday.response :logger, ::Logger.new(STDOUT), bodies: true
        faraday.adapter Faraday.default_adapter
        faraday.use Faraday::Response::RaiseError
      end
    end

    def body_to_json(body)
      if body
        body.is_a?(String) ? body : body.to_json
      else
        nil
      end
    end
  end
end
