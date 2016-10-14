class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = find_user_from_params
    authenticated_user = user.authenticate(params[:session][:password]) if user
    if authenticated_user
      session[:id] = user.id
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
    params.require(:session).permit(:username, :password)
  end

  def find_user_from_params
    return false unless params[:session][:email].present? &&
                        params[:session][:password].present?
    User.find_by_email(params[:session][:email])
  end
end
