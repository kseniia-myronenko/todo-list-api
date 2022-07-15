FactoryBot.define do
  factory :image do
    association :comment, factory: :comment
    link { FFaker::Image.url }
  end
end
