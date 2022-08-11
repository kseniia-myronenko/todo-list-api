class BaseController < ActionController::API
  include ActionController::Helpers
  include ActionController::RequestForgeryProtection

  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def render_not_found
    head :not_found
  end
end
