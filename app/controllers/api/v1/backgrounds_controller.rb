class Api::V1::BackgroundsController < ApplicationController
  def create
    render json: ImageSerializer.new(UnsplashFacade.create_image(params[:location]))
  end
end
