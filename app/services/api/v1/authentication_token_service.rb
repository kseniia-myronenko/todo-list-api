module Api
  module V1
    class AuthenticationTokenService
      ALGORITHM_TYPE = 'HS256'.freeze

      def initialize(user)
        @user = user
      end

      def call
        generate_access_token
      end

      private

      def generate_access_token
        ::JsonWebToken.encode({ user_id: @user.id }, Rails.application.credentials.jwt_secret, ALGORITHM_TYPE)
      end
    end
  end
end
