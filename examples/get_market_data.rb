require_relative "example_config"

pp Thirdparty::Market::Symbol.get_quote("GOOG")

# #<Thirdparty::Market::Symbol:0x007fe1f12af690
#  @response_json=
#   {"symbol"=>"GOOG",
#    "company_name"=>"Alphabet Inc.",
#    "exchange"=>"NGS",
#    "exchange_name"=>"Nasdaq Global Select",
#    "time"=>"2017-06-05T16:22:06-04:00",
#    "asset_type"=>"equity",
#    "price"=>
#     {"bid"=>{"price"=>982.7, "size"=>100},
#      "ask"=>{"price"=>984.03, "size"=>100},
#      "last_price"=>983.68,
#      "last_time"=>"2017-06-05T16:00:00-04:00",
#      "prev_close"=>975.6,
#      "trade_volume"=>20465,
#      "change"=>8.08,
#      "change_percent"=>0.828208,
#      "open"=>976.55,
#      "high"=>986.91,
#      "low"=>975.1,
#      "share_volume"=>1244597,
#      "vwap"=>983.210385,
#      "total_value"=>1223510910,
#      "week52high"=>{"date"=>"2017-05-31", "value"=>979.27},
#      "week52low"=>{"date"=>"2016-06-27", "value"=>663.284}},
#    "fundamental"=>
#     {"shares_outstanding"=>691748603,
#      "market_cap"=>680459265799,
#      "eps"=>29.5699996,
#      "pe_ratio"=>33,
#      "pb_ratio"=>4.694,
#      "shares_escrow"=>0}},
