class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validate :unique_project_name

  def unique_project_name
    unique_project = Project.where(name:, user_id:).where.not(id:)

    errors.add(:base, :already_exists) if unique_project.exists?
  end

  def completed_project?
    !tasks.where(done: false).exists?
  end
end
