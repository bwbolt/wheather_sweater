class Api::V1::MunchiesController < ApplicationController
  def create
    if params[:location]
      render json: MunchieSerializer.new(Munchie.new(params[:food], params[:location]))
    else
      render json: { error: 'Location Required' }, status: :bad_request
    end
  end
end
