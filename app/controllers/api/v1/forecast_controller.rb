class Api::V1::ForecastController < ApplicationController
  def index
    # Use mapquest api to get lat long
    location = MapquestFacade.get_coord(params[:location])
    forecast = OpenweatherFacade.create_forecast(location)

    render json: ForecastSerializer.new(forecast)
  end
end
