class User < ApplicationRecord
  has_secure_password

  USERNAME_MIN_LENGTH = 3
  USERNAME_MAX_LENGTH = 50
  PASSWORD_MIN_LENGTH = 8
  PASSWORD_REGEXP = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}\z/

  has_many :projects, dependent: :destroy

  validates :username, :password_digest, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { in: USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH }
  validates :password_digest, length: { minimum: PASSWORD_MIN_LENGTH }
  validates :password_digest, format: { with: PASSWORD_REGEXP }
end
