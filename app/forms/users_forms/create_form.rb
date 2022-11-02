module UsersForms
  class CreateForm < BaseForm
    PASSWORD_MIN_LENGTH = 8
    PASSWORD_REGEXP = /\A[a-zA-Z0-9]*.{8,}\z/

    property :password
    property :password_confirmation, virtual: true

    validates :password, length: { minimum: PASSWORD_MIN_LENGTH }
    validates :password, format: { with: PASSWORD_REGEXP }
  end
end
