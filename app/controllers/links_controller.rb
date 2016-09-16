class LinksController < ApplicationController
  #before_action :set_link, only: [:show]
  before_action :find_link, only: [:show, :edit, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :show, :destroy]

  def index
    @recent_links = Link.newest_first
    @popular_links = Link.popular
    @influential_users = User.top_users
    @new_link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if current_user
      update_current_user(@link)
      flash[:link] = "#{@link.display_slug}"
      flash[:notice] = "Link successfully created"
      redirect_to action: 'index'
    elsif @link.save
      flash[:link] = "#{@link.display_slug}"
      redirect_to action: 'index'
    else
      redirect_to action: 'index'
      flash[:error] = 'Something went wrong'
    end
  end

  def edit
  end

  def update
  end

  def show
    @link = Link.find(params[:id])
  end

  def destroy
    @link.destroy
    flash[:notice] = Message.link_deleted
    if current_user
      redirect_to 'users/index'
    else
      redirect_to root_path
    end

  end

  private
    def link_params
      params.require(:link).permit(:given_url)
    end

    def set_link
      @link = Link.find_by(slug: params[:slug])
    end

    def find_link
      @link = Link.find(params[:id])
    end

    def update_current_user(link)
      current_user.links << link
      current_user.link_count += 1
      current_user.save
    end
end
