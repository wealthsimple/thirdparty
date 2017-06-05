require_relative "example_config"

# Domestic account
account_id = "fa1c6f7b-07ed-429d-a9a2-257e97658d58"

funding_source_id = SecureRandom.uuid

funding_source = Thirdparty::Account::FundingSource.create(account_id, funding_source_id, {
  "type": "wire",
  "label": "My Australian Bank Account",
  "client_verified": false,
  "bank_account": {
    "account_number": "12345",
    "account_type": "savings",
    "bank": {
      "name": "Bank of Queensland",
      "swift_code": "QBANAU4B",
      "address": {
        "line_1": "100 Skyring Terrace",
        "country": "AUS"
      }
    }
  }
})
pp funding_source

# #<Thirdparty::Account::FundingSource:0x007fa0d6908b88
#  @response_json=
#   {"type"=>"wire",
#    "label"=>"My Australian Bank Account",
#    "client_verified"=>false,
#    "bank_account"=>
#     {"account_type"=>"savings",
#      "account_number"=>"12345",
#      "bank"=>
#       {"name"=>"Bank of Queensland",
#        "address"=>{"line_1"=>"100 Skyring Terrace", "country"=>"AUS"},
#        "swift_code"=>"QBANAU4B"},
#      "recipient"=>nil,
#      "intermediary_bank"=>nil},
#    "source_id"=>"47ec6f8b-88bc-4229-8e8e-d4fdf017c68f",
#    "status"=>"new",
#    "capabilities"=>{"deposit"=>false, "withdraw"=>true}},


transfer_id = SecureRandom.uuid

begin
  transfer = Thirdparty::Account::Transfer.create(account_id, transfer_id, {
    amount: 3.50,
    source_id: funding_source_id,
  })

  pp transfer

rescue Faraday::Error => e
  p e.response

  # {\"error\":\"The source is not active\",\"code\":\"RULES\"}\n"}
end

begin
  Thirdparty::Account::FundingSource.delete(account_id, funding_source_id)
rescue Faraday::Error => e
  p e.response
end
