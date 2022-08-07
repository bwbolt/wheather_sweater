class Api::V1::ForecastController < ApplicationController
  def index
    # Use mapquest api to get lat long
    location = MapquestFacade.get_coord(params[:location])
    forcast = OpenweatherFacade.create_forcast(location)

    render json: ForcastSerializer.new(forcast)
  end
end
