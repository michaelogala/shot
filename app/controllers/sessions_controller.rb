class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    authenticated_user = @user.authenticate(session_params[:password]) if @user
    if authenticated_user
      session[:id] = @user.id
      redirect_to dashboard_path, notice: logged_in
    else
      flash[:notice] = log_in_error
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path, notice: logged_out
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def set_user
    @user ||= User.find_by(email: session_params[:email])
  end
end
