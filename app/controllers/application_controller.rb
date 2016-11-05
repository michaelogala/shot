class ApplicationController < ActionController::Base
  include MessageHelper
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  attr_reader :api_user
  private

  def confirm_logged_in
    return true if session[:id]
    flash[:notice] = require_login
    redirect_to sign_in_path
  end

  #api
  def authenticate_user
    @api_user = User.find_by(id: decode_token[:user_id])
    render json: { errors: 'Invalid Token' } unless @api_user
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: 'Unauthorized Access' }
  end

  private

  def decode_token
    JsonWebToken.decode(token)
  end

  def token
    request.headers['Authorization']
  end
end
