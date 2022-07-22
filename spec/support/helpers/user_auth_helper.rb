module Helpers
  module UserAuthHelper
    PASSWORD = 'securepassword'.freeze
    WRONG_PASSWORD = 'wrongpassword'.freeze

    def authorized
      post api_v1_sessions_path, params: { username: user.username, password: PASSWORD }
    end

    def not_authorized
      post api_v1_sessions_path, params: { username: user.username, password: WRONG_PASSWORD }
    end

    private

    def user
      FactoryBot.create(:user, password: PASSWORD)
    end
  end
end
