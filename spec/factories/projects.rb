FactoryBot.define do
  factory :project do
    association :user, factory: :user
    name { FFaker::HipsterIpsum.sentence }

    trait :empty_name do
      name { nil }
    end

    trait :without_user do
      user { nil }
    end
  end
end
