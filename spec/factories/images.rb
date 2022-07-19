FactoryBot.define do
  factory :image do
    association :comment, factory: :comment
    image { FFaker::Image.url }

    trait :without_comment do
      comment_id { nil }
    end
  end
end
