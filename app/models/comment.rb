class Comment < ApplicationRecord
  COMMENT_MIN_LENGTH = 10
  COMMENT_MAX_LENGTH = 256

  belongs_to :task
  has_many :images, dependent: :destroy
  validates :content, presence: true
  validates :content, length: { in: COMMENT_MIN_LENGTH..COMMENT_MAX_LENGTH }
end
