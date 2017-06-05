module Thirdparty
  class Account < Resource
    class FundingSource < Resource
      def self.create(account_id, source_id, attributes)
        response = Request.post("/v1/accounts/#{account_id}/sources/#{source_id}", body: attributes)
        new(response)
      end

      def self.find(account_id, source_id)
        response = Request.get("/v1/accounts/#{account_id}/sources/#{source_id}")
        new(response)
      end

      def self.delete(account_id, source_id)
        response = Request.delete("/v1/accounts/#{account_id}/sources/#{source_id}")
        true
      end
    end
  end
end
