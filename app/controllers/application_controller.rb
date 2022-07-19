class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]

    begin
      JWT.decode(token, Rails.application.credentials.jwt_secret, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!current_user
  end

  def authorized
    return if logged_in?

    render json: { message: I18n.t('activerecord.errors.authorization.not_authorized') }, status: :unauthorized
  end
end
