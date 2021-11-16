FactoryBot.define do
  factory :payment do
    payment_type { 'Bank' }
    card_number { '4242424242424242' }
    exp_month { '12' }
    exp_year { '2024' }
    cvc { '123' }
    billing_zip { Faker::Address.zip_code }
    account_number { Faker::Bank.account_number }
    routing_number { Faker::Bank.routing_number }
    amount_cents { 1_0000 }
    bill_me_on { nil }
    merchant_id { nil }
  end
end