require_relative "example_config"

# Domestic account
account_id = "fa1c6f7b-07ed-429d-a9a2-257e97658d58"

pp Thirdparty::Account::Portfolio.get_cash_transactions(account_id)

# #<Thirdparty::Account::Portfolio:0x007fe30b95a218
#  @response_json=
#   {"items"=>
#     [{"transaction_id"=>27353,
#       "amount"=>3.5,
#       "transaction_time"=>"2017-06-05T18:01:03-04:00",
#       "settlement_time"=>"2017-06-06T14:01:02-04:00",
#       "description"=>"ACH Deposit",
#       "reconciled"=>false}],
#    "_head"=>
#     "/v1/accounts/fa1c6f7b-07ed-429d-a9a2-257e97658d58/portfolio/cash/USD/transactions?until=27353",
#    "_tail"=>
#     "/v1/accounts/fa1c6f7b-07ed-429d-a9a2-257e97658d58/portfolio/cash/USD/transactions?since=27353"},

symbol = "GOOG"
pp Thirdparty::Account::Portfolio.get_equities_transactions(account_id, symbol)

# #<Thirdparty::Account::Portfolio:0x007fe30b0f3b10
#  @response_json={"items"=>[]},
