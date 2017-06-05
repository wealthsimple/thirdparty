require_relative "example_config"

# Domestic account
account_id = "fa1c6f7b-07ed-429d-a9a2-257e97658d58"

funding_source_id = SecureRandom.uuid

funding_source = Thirdparty::Account::FundingSource.create(account_id, funding_source_id, {
  "type": "ach",
  "label": "My Account",
  "client_verified": true,
  "verification_method": "plaid",
  "bank_account": {
    "account_number": "12345",
    "account_type": "savings",
    "bank": {
      "name": "Bank of America",
      "routing_number": "123456789"
    }
  }
})
pp funding_source

# #<Thirdparty::Account::FundingSource:0x007fe3a9adbf58
#  @response_json=
#   {"type"=>"ach",
#    "label"=>"My Account",
#    "verification_method"=>"plaid",
#    "client_verified"=>true,
#    "bank_account"=>
#     {"account_type"=>"savings",
#      "account_number"=>"12345",
#      "bank"=>{"name"=>"Bank of America", "routing_number"=>"123456789"},
#      "recipient"=>nil,
#      "intermediary_bank"=>nil},
#    "source_id"=>"9bd75080-a6ee-445f-9ce3-27ab41df279e",
#    "status"=>"pending",
#    "capabilities"=>{"deposit"=>true, "withdraw"=>true}},

# Wait for status to become active.
sleep 5

transfer_id = SecureRandom.uuid

begin
  transfer = Thirdparty::Account::Transfer.create(account_id, transfer_id, {
    amount: 3.50,
    source_id: funding_source_id,
  })

  pp transfer

  # #<Thirdparty::Account::Transfer:0x007fcf061936d8
  #  @response_json=
  #   {"source_id"=>"52dfb06a-7b18-4649-9a61-c584f33bac20",
  #    "amount"=>3.5,
  #    "transfer_id"=>"a8e2f386-becf-418c-a773-8080c1cfe1f5",
  #    "status"=>"pending",
  #    "timestamp"=>"2017-06-05T18:01:02-04:00",
  #    "fees"=>nil,
  #    "notes"=>nil}
  
rescue Faraday::Error => e
  p e.response
end

begin
  Thirdparty::Account::Transfer.delete(account_id, transfer_id)
rescue Faraday::Error => e
  p e.response
end

begin
  Thirdparty::Account::FundingSource.delete(account_id, funding_source_id)
rescue Faraday::Error => e
  p e.response
end
