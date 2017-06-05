module Thirdparty
  module Market
    class Symbol < Resource
      # 15-minute delayed quote (Yahoo Finance?)
      def self.get_quote(symbol)
        response = Request.get("/v1/market/symbols/#{symbol}/quote")
        new(response)
      end
    end
  end
end
