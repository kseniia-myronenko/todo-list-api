FactoryBot.define do
  factory :user do
    username do
      FFaker::Internet.unique.user_name.ljust(UsersForms::BaseForm::USERNAME_MIN_LENGTH,
                                              'a')[0...UsersForms::BaseForm::USERNAME_MAX_LENGTH]
    end
    password { 'Password7&' }
    password_confirmation { password }

    trait :with_empty_username do
      username { nil }
    end

    trait :with_empty_password do
      password { nil }
    end
  end
end
