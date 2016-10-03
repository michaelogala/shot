class RedirectsController < ApplicationController
  include RedirectsHelper
  layout false

  def inactive
  end

  def show
    link = Link.find_by(slug: params[:slug])
    if link
      if link.active?
        visit_and_update(link)
      else
        render 'inactive'
      end
    else
      render 'deleted'
    end

  end

  def deleted
  end

  private

  def visit_and_update(link)
    if redirect_to link.given_url
      link.visits << Visit.new(visit_params(request))
      link.update_attributes(clicks: link.clicks + 1)
    end
  end
end
