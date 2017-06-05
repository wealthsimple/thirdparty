module Thirdparty
  class Account < Resource
    class Transfer < Resource
      def self.create(account_id, transfer_id, attributes)
        response = Request.post("/v1/accounts/#{account_id}/transfers/#{transfer_id}", body: attributes)
        new(response)
      end

      def self.find(account_id, transfer_id)
        response = Request.get("/v1/accounts/#{account_id}/transfers/#{transfer_id}")
        new(response)
      end

      def self.delete(account_id, transfer_id)
        response = Request.delete("/v1/accounts/#{account_id}/transfers/#{transfer_id}")
        true
      end
    end
  end
end
