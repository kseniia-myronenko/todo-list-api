class AuthorizedController < BaseController
  before_action :unauthorized_request

  def unauthorized_request
    render json: { message: I18n.t('authentication.errors.not_logged_in') }, status: :unauthorized unless current_user
  end
end
