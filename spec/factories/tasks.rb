FactoryBot.define do
  factory :task do
    name { 'MyString' }
    project { nil }
    status { 1 }
    deadline { '2022-07-13 15:17:14' }
  end
end
