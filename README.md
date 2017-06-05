# Thirdparty [![CircleCI](https://circleci.com/gh/wealthsimple/thirdparty.svg?style=svg)](https://circleci.com/gh/wealthsimple/thirdparty)

Rubygem for making API calls to Thirdparty.com Trade API.

This is more of a proof-of-concept at this point to demonstrate how to make most requests in the Sandbox environment.

## Usage

To use the `thirdparty` gem, just require and configure it with the OAuth credentials you've been provided with:

```ruby
require "thirdparty"

Thirdparty.configure do |config|
  config.base_url = "https://api.sandbox.thirdparty.com"
  config.client_id = "my-client-id"
  config.client_secret = "my-client-secret"
end
```

You can verify that the authentication is working properly by running:

```ruby
Thirdparty::Oauth.access_token
=> "some-access-token"
```

#### Creating an account

See [API documentation](https://portal.thirdparty.com/docs/accounts.html) for details on fields. The below will make a request to create a domestic account with a single applicant.

```ruby
account_id = "my-unique-account-id"
account = Thirdparty::Account.create(account_id, {
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
```

#### Creating a funding source and transfer

Once you've created an account, you can now fund it:

```ruby
# First, create a funding source for the above account:
funding_source_id = "my-unique-funding-source-id"
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

# Wait for status to become active.
# TODO: use Events API for a less error-prone way to check if active.
sleep 5

transfer_id = "my-unique-transfer-id"
transfer = Thirdparty::Account::Transfer.create(account_id, transfer_id, {
  amount: 3.50,
  source_id: funding_source_id,
})
```

#### Fetching account transactions

Once your funds transfer is submitted, you can view the pending ACH deposit by fetching transactions:

```ruby
cash_transactions = Thirdparty::Account::Portfolio.get_cash_transactions(account_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
