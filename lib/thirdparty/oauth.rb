module Thirdparty
  class Oauth
    def self.access_token
      return @access_token if @access_token.present? && !expired?

      response = Request.post("/oauth/token",
        body: {
          client_id: Thirdparty.configuration.client_id,
          client_secret: Thirdparty.configuration.client_secret,
          grant_type: "client_credentials",
        },
        authenticated: false,
      )
      token = Resource.new(response)
      @expiry = DateTime.parse(token.expiry)
      @access_token = token.access_token
    end

    # If it's 1 minute from being expired, consider it to be expired.
    def self.expired?
      @expiry.nil? || 1.minute.from_now.to_datetime >= @expiry
    end
  end
end
