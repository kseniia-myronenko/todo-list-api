class Image < ApplicationRecord
  ALLOWED_MIME_TYPES = %w[image/jpeg image/png].freeze
  ALLOWED_EXTENSIONS = %w[jpg jpeg png].freeze
  MAX_SIZE = 10 * 1024 * 1024
  THUMBNAIL_SIZE = { thumb: [300, 300] }.freeze

  belongs_to :comment

  validates :image_data, presence: true

  include ImageUploader::Attachment(:image)
end
