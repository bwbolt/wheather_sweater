class Api::V1::ForecastController < ApplicationController
  def index
    # Use mapquest api to get lat long
    location = MapquestFacade.get_coord(params[:location])

    binding.pry
    render json: 'HI'

    #  coord[:results][0][:locations][0][:latLng]
  end
end
