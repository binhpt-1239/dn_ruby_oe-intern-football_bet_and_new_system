FactoryBot.define do
  factory :team do
    name {Faker::Sports::Football.team}

    trait :home do
      name {Faker::Sports::Football.team}
    end

    trait :guest do
      name {Faker::Sports::Football.team}
    end

    factory :home_team, class: Team, traits: [:home]
    factory :guest_team, class: Team, traits: [:guest]
  end
end
