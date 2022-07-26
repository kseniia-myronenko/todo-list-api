class BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def render_not_found
    head :not_found
  end
end
