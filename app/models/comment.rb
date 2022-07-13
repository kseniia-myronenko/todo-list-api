class Comment < ApplicationRecord
  belongs_to :task
  has_many :images, dependent: :destroy

  include ImageUploader::Attachment(:image)
end
