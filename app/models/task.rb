class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy

  validate :deadline_is_a_date?
  validates :name, presence: true

  def deadline_is_a_date?
    return if deadline.is_a?(Date) || deadline.nil?

    errors.add(:deadline, :invalid)
  end
end
