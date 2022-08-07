class Api::V1::ForecastController < ApplicationController
  def index
    # Use mapquest api to get lat long
    location = MapquestFacade.get_coord(params[:location])

    weather = OpenweatherFacade.create_forcast(location)

    binding.pry
    render json: 'HI'
  end
end
