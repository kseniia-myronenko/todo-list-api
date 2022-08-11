module Helpers
  module UserAuthHelper
    PASSWORD = 'securepassword'.freeze

    def authenticate(user)
      post api_v1_login_path, params: { username: user.username, password: PASSWORD }
    end

    def basic_token(user)
      ActionController::HttpAuthentication::Basic.encode_credentials(user.username, Helpers::UserAuthHelper::PASSWORD)
    end
  end
end
