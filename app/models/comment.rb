class Comment < ApplicationRecord
  belongs_to :task
  has_many :images, dependent: :destroy
  validates :content, presence: true
end
