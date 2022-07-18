FactoryBot.define do
  factory :user do
    username { FFaker::Internet.unique.user_name.ljust(User::USERNAME_MIN_LENGTH, 'a')[0...User::USERNAME_MAX_LENGTH] }
    hashed_password { "#{FFaker::Internet.password}7&".ljust(User::PASSWORD_MIN_LENGTH, 'a') }

    trait :with_empty_username do
      username { nil }
    end

    trait :with_empty_password do
      hashed_password { nil }
    end
  end
end
