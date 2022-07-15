FactoryBot.define do
  factory :task do
    association :project, factory: :project
    name { FFaker::HipsterIpsum.phrase }
    priority { nil }
    deadline { '2022-07-13 15:17:14' }
    done { FFaker::Boolean.random }

    trait :empty_name do
      name { nil }
    end

    trait :without_project do
      project { nil }
    end
  end
end
