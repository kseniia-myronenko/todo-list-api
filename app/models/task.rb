class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, dependent: :destroy
  acts_as_list scope: :project

  validate :deadline_is_a_date?
  validate :deadline_is_the_past_date?
  validates :name, presence: true

  def deadline_is_a_date?
    return if deadline.is_a?(Date) || deadline.nil?

    errors.add(:deadline, :invalid)
  end

  def deadline_is_the_past_date?
    return unless deadline.is_a?(Date) && deadline.present? && deadline < Time.zone.now

    errors.add(:deadline, :past)
  end
end
