class User < ApplicationRecord
  USERNAME_MIN_LENGTH = 3
  USERNAME_MAX_LENGTH = 50
  PASSWORD_MIN_LENGTH = 8
  PASSWORD_REGEXP = '/^[a-zA-Z0-9]+$/'.freeze

  has_many :projects, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
end
