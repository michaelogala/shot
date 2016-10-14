# get rid of this class and move actions to link controller
class RedirectsController < ApplicationController
  include RedirectsHelper
  layout false

  def inactive
  end

  def show
    link = Link.find_by(slug: params[:slug])
    return render 'deleted' unless link
    if link.active?
      redirect_and_update(link)
    else
      render 'inactive'
    end
  end

  def deleted
  end

  private

  def redirect_and_update(link)
    if redirect_to link.given_url
      link.visits << Visit.new(visit_params(request))
      link.update_attributes(clicks: link.clicks + 1)
    end
  end
end
