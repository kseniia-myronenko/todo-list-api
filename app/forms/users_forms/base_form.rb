require 'reform/form/validation/unique_validator'

module UsersForms
  class BaseForm < ApplicationForm
    USERNAME_MIN_LENGTH = 3
    USERNAME_MAX_LENGTH = 50

    model :user

    property :username
    property :password

    validates :username, :password, presence: true
    validates :username, unique: { case_sensitive: false }
    validates :username, length: { in: USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH }
  end
end
