require_relative "example_config"

domestic_account_id = SecureRandom.uuid
domestic_account = Thirdparty::Account.create(domestic_account_id, {
  "customer_type": "individual",
  "applicants": [
    {
      "name": {
        "first": "Test",
        "middle": "Demo", # Set to Demo to remove simulated delay in account opening.
        "last": "User"
      },
      "ssn": "123-45-6789",
      "address": {
        "line_1": "123 Fake Street",
        "city": "Test",
        "state": "Test",
        "postal_code": "12345",
        "country": "USA"
      },
      "employment_status": "employed",
      "birthday": "1990-12-22",
      "email": "abcd1234@test.com",
      "citizenship_country": "USA",
      "mobile": "123456789"
    }
  ]
})

pp domestic_account

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

pp Thirdparty::Account.find(domestic_account_id)

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
