FactoryBot.define do
  factory :user_bet do
    user_id { 3 }
    amount  { 10000 }
    result_bet { true }
    bet_id { 1 }
  end
end
