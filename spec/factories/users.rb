FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    admin {1}
    remember_digest{0}

    trait :client do
      admin {0}
    end

    factory :client_user, class: User, traits: [:client]
  end
end
