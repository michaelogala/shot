class LinksController < ApplicationController
  before_action :find_link, only: [:show, :update, :destroy, :activate, :deactivate]
  before_action :authenticate_user!, only: [:edit, :update, :show, :destroy]

  def index
    redirect_to '/dashboard' if current_user
    @recent_links = Link.newest_first
    @popular_links = Link.popular
    @influential_users = User.top_users
    @new_link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id if current_user
    if @link.save
      flash[:link] = "#{@link.display_slug}"
      flash[:notice] = "Link successfully created"
      redirect_to :back
    else
      render 'index'
      flash[:error] = 'Something went wrong'
    end
  end

  def edit
  end

  def update
    params = link_params
    params[:slug] = params[:slug].gsub(' ', '-')
    if @link.update(params)
      flash[:notice] = Message.link_updated
      redirect_to '/dashboard'
    end
  end

  def activate
    @link.update_attributes(active: true)
    flash[:notice] = Message.link_activated
      redirect_to '/dashboard'
  end

  def deactivate
    if @link.update_attributes(active: false)
      flash[:notice] = Message.link_deactivated
      redirect_to '/dashboard'
    end
  end

  def show
  end

  def destroy
    @link.destroy
    flash[:notice] = Message.link_deleted
    redirect_to root_path
  end

  private

    def link_params
      params.require(:link).permit(:given_url, :slug, :active, :id)
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
