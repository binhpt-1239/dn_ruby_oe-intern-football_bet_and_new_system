FactoryBot.define do
  factory :bet do
    soccer_match_id {1}
    rate {0.9}
    bet_type {1}
    content {"Team Home Win"}
  end
end
