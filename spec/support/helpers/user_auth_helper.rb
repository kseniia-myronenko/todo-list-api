module Helpers
  module UserAuthHelper
    USERNAME = 'username'.freeze
    PASSWORD = 'securepassword'.freeze

    def authenticate(user)
      post api_v1_login_path, params: { username: user.username, password: PASSWORD }
    end
  end
end
