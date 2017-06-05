require_relative "example_config"

image = File.read("./examples/fixtures/image.png")
begin
  # TODO: what is file? Undocumented.
  file = Thirdparty::File.create(file: {}, purpose: "id_document")
  pp file
rescue Faraday::Error => e
  p e.response
  exit 1
end


account_id = SecureRandom.uuid
account = Thirdparty::Account.create(account_id, {
  "customer_type": "individual",
  "foreign_application": {
    "nature_of_business": "Developer",
    "banks": [
      "Westpac"
    ],
    "estimated_initial_deposit": 10,
    "activity_type": "active_trading",
    "expected_withdrawals": "frequent"
  },
  "risk_profile": {
    "time_horizon": "1_to_5_years",
    "liquidity_needs": "somewhat_important",
    "investment_objective": "growth",
    "investment_experience": "none",
    "risk_tolerance": "conservative",
    "annual_income": "0-25000",
    "liquid_net_worth": "0-50000",
    "total_net_worth": "0-50000"
  },
  "applicants": [
    {
      "name": {
        "first": "Test",
        "middle": "Demo",
        "last": "User"
      },
      "w8_ben_tax_id": "123-45-6789",
      "address": {
        "line_1": "123 Fake Street",
        "city": "Test",
        "state": "Test",
        "postal_code": "12345",
        "country": "AUS"
      },
      "employer": "Acme Co.",
      "employment_status": "employed",
      "documents": [
        {
          "file_id": file.id,
          "type": "id_document"
        },
        {
          "file_id": "654321",
          "type": "signature_image"
        }
      ],
      "birthday": "1990-12-22",
      "email": "abcd1234@test.com",
      "birth_country": "AUS",
      "citizenship_country": "AUS",
      "mobile": "123456789"
    }
  ]
})

pp account

# #<Thirdparty::Account:0x007fb42713d868
#  @response_json=
#   {"account_id"=>"fa1c6f7b-07ed-429d-a9a2-257e97658d58",
#    "status"=>"pending",
#    "customer_type"=>"individual",
#    "options"=>false,
#    "applicants"=>
#     [{"applicant_id"=>"bc182a29-9098-4af8-9e2f-5ecf4fef3788",
#       "name"=>{"first"=>"Test", "middle"=>"Demo", "last"=>"User"},
#       "email"=>"abcd1234@test.com",
#       "birthday"=>"1990-12-22",
#       "ssn"=>"***-**-6789",
#       "citizenship_country"=>"USA",
#       "mobile"=>"123456789",
#       "address"=>
#        {"line_1"=>"123 Fake Street",
#         "city"=>"Test",
#         "state"=>"Test",
#         "postal_code"=>"12345",
#         "country"=>"USA"},
#       "employment_status"=>"employed"}],
#    "notes"=>
#     [{"note"=>"Status changed to Pending",
#       "timestamp"=>"2017-06-05T21:02:50+00:00"},
#      {"note"=>"Account information submitted",
#       "timestamp"=>"2017-06-05T21:02:50+00:00"}],
#    "can_fund"=>false,
#    "can_trade"=>false,
#    "can_trade_options"=>false},

# Wait for account approval (usually takes a few seconds)
sleep 5

pp Thirdparty::Account.find(account_id)

# #<Thirdparty::Account:0x007ff3a509cf90
#  @response_json=
#   {"account_id"=>"fa1c6f7b-07ed-429d-a9a2-257e97658d58",
#    "status"=>"approved",
#    "customer_type"=>"individual",
#    "options"=>false,
#    "applicants"=>
#     [{"applicant_id"=>"bc182a29-9098-4af8-9e2f-5ecf4fef3788",
#       "name"=>{"first"=>"Test", "middle"=>"Demo", "last"=>"User"},
#       "email"=>"abcd1234@test.com",
#       "birthday"=>"1990-12-22",
#       "ssn"=>"***-**-6789",
#       "citizenship_country"=>"USA",
#       "mobile"=>"123456789",
#       "address"=>
#        {"line_1"=>"123 Fake Street",
#         "city"=>"Test",
#         "state"=>"Test",
#         "postal_code"=>"12345",
#         "country"=>"USA"},
#       "employment_status"=>"employed"}],
#    "notes"=>
#     [{"note"=>"Identity check passed",
#       "timestamp"=>"2017-06-05T21:02:52+00:00"},
#      {"note"=>"Status changed to Approved",
#       "timestamp"=>"2017-06-05T21:02:52+00:00"},
#      {"note"=>"Status changed to Pending",
#       "timestamp"=>"2017-06-05T21:02:50+00:00"},
#      {"note"=>"Account information submitted",
#       "timestamp"=>"2017-06-05T21:02:50+00:00"}],
#    "can_fund"=>true,
#    "can_trade"=>true,
#    "can_trade_options"=>false},
