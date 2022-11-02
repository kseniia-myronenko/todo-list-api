class TaskForm < ApplicationForm
  model :task
  property :name
  property :deadline
  property :position
  property :project_id
  property :done

  validates :name, :project_id, presence: true
  validate :deadline_is_a_date?
  validate :deadline_is_the_past_date?

  private

  def deadline_is_a_date?
    return if deadline.is_a?(Date) || deadline.nil?

    errors.add(:deadline, :invalid)
  end

  def deadline_is_the_past_date?
    return unless deadline.is_a?(Date) && deadline.present? && deadline < Time.zone.now

    errors.add(:deadline, :past)
  end
end
