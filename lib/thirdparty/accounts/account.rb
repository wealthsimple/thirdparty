module Thirdparty
  class Account < Resource
    def self.create(account_id, attributes)
      response = Request.post("/v1/accounts/#{account_id}", body: attributes)
      new(response)
    end

    def self.all
      response = Request.get("/v1/accounts")
      JSON.parse(response.body).map { |account| new(account) }
    end

    def self.find(account_id)
      response = Request.get("/v1/accounts/#{account_id}")
      new(response)
    end

    def self.update(account_id, attributes)
      response = Request.put("/v1/accounts/#{account_id}")
      new(response)
    end
  end
end
