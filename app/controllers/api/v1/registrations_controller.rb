module Api
  module V1
    class RegistrationsController < BaseController
      # before_action :forbid_authenticated

      def create
        user = User.new(user_params)
        if user.save
          session[:user_id] = user.id
          render json: { user: user.username,
                         message: I18n.t('authentication.success.sig_up') }, status: :created
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:username, :password, :password_confirmation)
      end
    end
  end
end
