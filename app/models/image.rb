class Image < ApplicationRecord
  ALLOWED_MIME_TYPES = %w[image/jpeg image/png].freeze
  ALLOWED_EXTENSIONS = %w[jpg jpeg png].freeze
  MAX_SIZE = 10 * 1024 * 1024

  belongs_to :comment
end
