class BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def render_not_found
    head :not_found
  end

  def forbid_authenticated
    render json: { message: I18n.t('authentication.errors.logged_in') }, status: :forbidden if logged_in?
  end

  def logged_in?
    !!current_user
  end
end
