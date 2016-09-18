class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  def show
    @link = Link.find_by(id: params[:link_id])
  end
end
