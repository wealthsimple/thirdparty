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

# Wait for account approval (usually takes a few seconds)
sleep 5

pp Thirdparty::Account.find(account_id)
