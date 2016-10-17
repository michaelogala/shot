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
      session[:id] = @user.id
      redirect_to dashboard_path, notice: new_user
    else
<<<<<<< HEAD
      flash.now[:notice] = sign_up_error
      render 'new'
=======
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to action: 'new'
>>>>>>> 2c97899c8c9b85aead56857ddc1d9718e4f6800d
    end
  end

  def show
    @link = Link.find_by(id: params[:link_id])
    @links = @user.links
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation)
  end

  def find_user_from_session
    @user = User.find(session[:id])
  end
end
