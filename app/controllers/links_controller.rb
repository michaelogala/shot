class LinksController < ApplicationController
  include Concerns::Utility
  extend Concerns::Message
  before_action :confirm_logged_in,
    except: [:index, :create]
  before_action :normalize_params, only: [:update]
  before_action :find_link, only: [:show, :update, :destroy, :activate, :deactivate]

  def index
    @recent_links = Link.newest_first
    @popular_links = Link.popular
    @influential_users = User.top_users
    @new_link = Link.new
  end

  def create
    @link = Link.new(normalize_params)
    update_current_user(@link)
    if @link.save
      flash[:link] = Message.display_link(@link)
      flash[:notice] = Message.new_link_success
      redirect_to :back
    else
      flash[:error] = Message.new_link_error
      redirect_to :back
    end
  end

  def update
    if @link.update_attributes(normalize_params)
      flash[:notice] = Message.link_updated
      redirect_to dashboard_path
    end
  end

  def activate
    @link.update_attributes(active: true)
    flash[:notice] = Message.link_activated
    redirect_to dashboard_path
  end

  def deactivate
    if @link.update_attributes(active: false)
      flash[:notice] = Message.link_deactivated
      redirect_to dashboard_path
    end
  end

  def destroy
    @link.destroy
    flash[:notice] = Message.link_deleted
    redirect_to dashboard_path
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

    def find_link_by_url(link)
      Link.find_by(given_url: link.given_url)
    end

    def update_current_user(link)
      if current_user
        current_user.links << link
        current_user.link_count += 1
        current_user.save
      end
    end

    def normalize_params
      params = link_params
      params[:slug] = SecureRandom.urlsafe_base64(4) if params[:slug].blank?
      params[:slug] = params[:slug].gsub(' ', '-')
      params
    end
end
