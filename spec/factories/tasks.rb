FactoryBot.define do
  factory :task do
    association :project, factory: :project
    name { FFaker::HipsterIpsum.phrase }
    priority { nil }
    deadline { '2027-07-13' }
    done { FFaker::Boolean.random }

    trait :empty_name do
      name { nil }
    end

    trait :without_project do
      project { nil }
    end
  end
end
