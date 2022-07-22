module Api
  module V1
    class SessionsController < BaseController
      # before_action :forbid_authenticated

      def create
        if set_user&.authenticate(params[:password])
          session[:user_id] = set_user.id
          render json: { user: set_user.username,
                         logged_in: true,
                         message: I18n.t('authentication.success.logged_in') }, status: :created
        else
          render json: { message: I18n.t('authentication.errors.wrong_data') }, status: :unauthorized
        end
      end

      def destroy
        reset_session
        render json: { message: 'You have successfully logged out.' }, status: :ok
      end

      private

      def set_user
        User.find_by(username: params[:username])
      end
    end
  end
end
