class ApplicationController < ActionController::Base
  include MessageHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def confirm_logged_in
    unless session[:id]
      flash[:notice] = require_login
      redirect_to controller: :users, action: 'sign_in'
    end
  end
end
