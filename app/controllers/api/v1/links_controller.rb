module Api
  module V1
    class LinksController < ApplicationController
      respond_to :json

      def index
        render json: { links: Link.all }, status: 200
      end
    end
  end
end
