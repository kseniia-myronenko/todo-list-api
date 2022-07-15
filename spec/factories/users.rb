FactoryBot.define do
  factory :user do
    username { FFaker::Internet.unique.user_name }
    hashed_password { FFaker::Internet.password }
  end
end
