FactoryBot.define do
  factory :image do
    association :comment, factory: :comment
    image { Rack::Test::UploadedFile.new('spec/fixtures/files/acceptable_size_image-2.png', 'image/png') }

    trait :without_comment do
      comment_id { nil }
    end

    trait :invalid_type do
      image { Rack::Test::UploadedFile.new('spec/fixtures/files/big_size_image.jpg', 'image/jpg') }
    end

    trait :jpg_format do
      image { Rack::Test::UploadedFile.new('spec/fixtures/files/acceptable_size_image-1.jpg', 'image/jpg') }
    end
  end
end
