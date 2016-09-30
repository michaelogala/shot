class UsersController < ApplicationController
  before_action :confirm_logged_in,
    except: [:new, :create, :sign_out, :sign_in, :attempt_login]
  before_action :find_user, only: [:edit, :update, :show]
  layout 'dashboard', except: [:new, :edit, :sign_in, :attempt_login]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = Message.new_user
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
    if params[:user][:email].present? && params[:user][:password].present?
      found_user = User.where(email: params[:user][:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:user][:password])
      end
    end
    if authorized_user
      session[:id] = authorized_user.id
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

  def find_user
    @user = User.find(session[:id])
  end
end
