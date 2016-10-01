class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:edit, :update, :show]
  before_action :find_user_from_session, only: [:edit, :update, :show]
  layout 'dashboard', only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = Message.new_user
      session[:id] = @user.id
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
    @link = Link.find_by(id: params[:link_id])
    @links = @user.links
  end

  def sign_in
  end

  def attempt_login
    autheticated_user = authenticate(find_user_from_params)
    if autheticated_user
      session[:id] = autheticated_user.id
      flash[:notice] = Message.logged_in
      redirect_to dashboard_path
    else
      flash[:notice] = Message.log_in_error
      render 'sign_in'
    end
  end

  def sign_out
    session[:id] = nil
    flash[:notice] = Message.logged_out
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def find_user_from_session
    @user = User.find(session[:id])
  end

  def find_user_from_params
    if params[:user][:email].present? && params[:user][:password].present?
      User.where(email: params[:user][:email]).first
    end
  end

  def authenticate(user)
    user.authenticate(params[:user][:password])
  end
end
