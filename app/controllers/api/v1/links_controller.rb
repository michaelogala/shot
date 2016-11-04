module Api
  module V1
    class LinksController < ApplicationController
      respond_to :json
      before_action :find_link, only: [:show, :update, :destroy]

      def index
        render json: { links: Link.all }, status: 200
      end

      def show
        render json: @link
      end

      def create
        link = Link.new(link_params)
        if link.save
          render json: link, status: 200
        else
          render json: { error: new_link_error }
        end
      end

      def update
        if @link.update_attributes(link_params)
          render json: @link, status: 200
        else
          render json: { errors: @link.errors }, status: 200
        end
      end

      def destroy
        @link.destroy
        head 204
      end

      private

      def link_params
        params.permit(
                      :given_url,
                      :slug,
                      :active,
                      :id
                      )
      end

      def find_link
        @link = Link.find_by(id: params[:id])
      end
    end
  end
end
