module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorized, only: [:create]

      def create
        @user = User.create(user_params)
        response = if @user.valid?
                     { json: { user: Api::V1::UserSerializer.new(@user), jwt: encode_token({ user_id: @user.id }) },
                       status: :created }
                   else
                     { json: { errors: @user.errors }, status: :unprocessable_entity }
                   end
        render response
      end

      private

      def user_params
        params.permit(:username, :password_digest)
      end
    end
  end
end
