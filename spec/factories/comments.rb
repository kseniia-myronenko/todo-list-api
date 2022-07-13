FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    task { nil }
    file_data { 'MyText' }
  end
end
