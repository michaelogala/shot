class RedirectsController < ApplicationController
include RedirectsHelper
extend Concerns::Message
layout false
  def inactive
  end

  def show
    if params[:slug]
      link = Link.find_by(slug: params[:slug])
      if !link
        render 'deleted'
      elsif link.active?
        visit_and_update(link)
      else
        render 'inactive'
      end
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
