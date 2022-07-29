FactoryBot.define do
  factory :task do
    association :project, factory: :project
    name { FFaker::HipsterIpsum.phrase }
    position { nil }
    deadline { nil }
    done { FFaker::Boolean.random }

    trait :empty_name do
      name { nil }
    end

    trait :without_project do
      project { nil }
    end

    trait :done do
      done { true }
    end

    trait :undone do
      done { false }
    end
  end
end
