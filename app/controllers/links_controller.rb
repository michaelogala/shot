class LinksController < ApplicationController
  include Concerns::Utility
  before_action :confirm_logged_in, except: [:index, :create]
  before_action :normalize_params, only: [:update]
  before_action :find_link, only: [
                                    :show,
                                    :update,
                                    :destroy,
                                    :toggle_activate
                                  ]

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
      respond_to_save
    else
      flash[:error] = new_link_error
      redirect_to :back
    end
  end

  def update
    if @link.update_attributes(normalize_params)
      flash[:notice] = link_updated
      redirect_to :back
    else
      flash[:notice] = @link.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def toggle_activate
    flash[:notice] = link_deactivated
    flash[:notice] = link_activated if params[:active] == 'true'
    @link.update_attributes(active: params[:active])
    redirect_to :back
  end

  def destroy
    @link.destroy
    flash[:notice] = link_deleted
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
    params[:slug] = params[:slug].tr(' ', '-')
    params
  end

  def respond_to_save
    flash[:link] = @link.display_slug
    flash[:slug] = @link.slug
    flash[:notice] = new_link_success
    redirect_to :back
  end
end
