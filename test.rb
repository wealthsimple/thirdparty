require "dotenv/load"
require "pp"
require "bundler/setup"
require "thirdparty"

Thirdparty.configure do |config|
  config.base_url = "https://api.sandbox.thirdparty.com/v1"
  config.client_id = ENV["CLIENT_ID"]
  config.client_secret = ENV["CLIENT_SECRET"]
end

p Thirdparty::Oauth.access_token, Thirdparty::Oauth.expired?
