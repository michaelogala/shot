class RedirectsController < ApplicationController

  def inactive
  end

  def show
    if params[:slug]
      link = Link.find_by(slug: params[:slug])
      if link.active?
        redirect_to link.given_url
        link.update_attributes(clicks: link.clicks + 1)
      else
        render 'inactive'
      end
    end
  end
end
