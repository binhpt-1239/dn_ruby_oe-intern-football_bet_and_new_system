FactoryBot.define do
  factory :soccer_match do
    home_id {1}
    guest_id {2}
    tournament_id {1}
    time {Time.now}
    status {0}
  end
end
