FactoryBot.define do
  factory :project do
    association :user, factory: :user
    name { FFaker::HipsterIpsum.sentence }
  end
end
