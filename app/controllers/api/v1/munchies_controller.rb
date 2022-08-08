class Api::V1::MunchiesController < ApplicationController
  def create
    render json: YelpFacade.create_resturant(params[:food], params[:location])
  end
end
