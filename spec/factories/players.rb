FactoryBot.define do
  factory :player do
    name {Faker::Sports::Football.player}
    position {Faker::Sports::Football.position}
    number {10}
  end
end
