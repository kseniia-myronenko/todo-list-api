FactoryBot.define do
  factory :comment do
    association :task, factory: :task
    content { FFaker::Lorem.sentence }

    trait :empty_content do
      content { nil }
    end

    trait :without_task do
      task { nil }
    end
  end
end
