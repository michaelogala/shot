class LinksController < ApplicationController
  before_action :confirm_logged_in, except: [:index, :create]
  before_action :find_link, except: [:index, :create, :show]
  layout 'dashboard', only: [:show]

  def index
    @index_presenter = Index::IndexPresenter.new
    @new_link = Link.new
  end

  def create
    @link = Link.new(link_params)
    current_user.add_new_link(@link) if current_user
    if @link.save
      set_flash_and_redirect
    else
      flash[:error] = new_link_error
      redirect_to :back
    end
  end

  def show
    @links = Link.find_links_for_user(current_user)
    @link = Link.find_by_id(params[:link_id])
  end

  def update
    flash[:notice] = if @link.update_attributes(link_params)
                       link_updated
                     else
                       @link.errors.full_messages.to_sentence
                     end
    redirect_to :back
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

  def set_flash_and_redirect
    flash[:link] = @link.display_slug
    flash[:slug] = @link.slug
    flash[:notice] = new_link_success
    redirect_to :back
  end
end
