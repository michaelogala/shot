class RedirectsController < ApplicationController

  def show
    if params[:slug]
      link = Link.find_by(slug: params[:slug])
      if redirect_to link.given_url
        link.update_attributes(clicks: link.clicks + 1)
      else
        flash[:error] = Message.unknown_link
        redirect_to root_path
      end
    end
  end
end
