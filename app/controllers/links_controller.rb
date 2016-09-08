class LinksController < ApplicationController
  before_action :set_link, only: [:show]

  def index
    @recent_links = Link.newest_first
    @popular_links = Link.popular
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:notice] = "#{@link.slug}"
      redirect_to action: 'index'
    else
      redirect_to action: 'index'
      flash[:error] = 'Something went wrong'
    end
  end

  def show
    if params[:slug]
      @link = Link.find_by(slug: params[:slug])
      if redirect_to @link.given_url
        @link.clicks += 1
        @link.save
      else
        @link = Link.find(params[:id])
      end
    end
  end

  def destroy
  end

  private
    def link_params
      params.require(:link).permit(:given_url)
    end

    def set_link
      @link = Link.find_by(slug: params[:slug])
    end
end
