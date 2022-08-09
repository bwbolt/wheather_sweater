class Api::V1::BackgroundsController < ApplicationController
  def create
    if params[:location]
      render json: ImageSerializer.new(UnsplashFacade.create_image(params[:location]))
    else
      render json: { error: 'Location Required' }, status: :bad_request
    end
  end
end
