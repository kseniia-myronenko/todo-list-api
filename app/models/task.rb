class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validate :deadline_is_date?
  validates :name, presence: true
  validates :name, uniqueness: true

  def deadline_is_date?
    return if deadline.is_a?(Date)

    errors.add(:deadline, :invalid)
  end
end
