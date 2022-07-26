class AuthorizedController < BaseController
  before_action :check_authorization

  private

  def check_authorization
    render status: :unauthorized unless current_user
  end
end
