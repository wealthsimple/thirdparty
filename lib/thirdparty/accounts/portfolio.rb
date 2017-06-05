module Thirdparty
  class Account < Resource
    class Portfolio < Resource
      def self.get_cash_transactions(account_id)
        response = Request.get("/v1/accounts/#{account_id}/portfolio/cash/USD/transactions")
        new(response)
      end

      def self.get_equities_transactions(account_id, symbol)
        response = Request.get("/v1/accounts/#{account_id}/portfolio/equities/#{symbol}/transactions")
        new(response)
      end
    end
  end
end
