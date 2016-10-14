class ApplicationController < ActionController::Base
  include MessageHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_logged_in
    return true if session[:id]
    flash[:notice] = require_login
    redirect_to sign_in_path
  end
end
