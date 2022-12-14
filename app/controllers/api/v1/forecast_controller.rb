class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location]
      location = MapquestFacade.get_coord(params[:location])
      forecast = OpenweatherFacade.create_forecast(location)

      render json: ForecastSerializer.new(forecast)
    else
      render json: { error: 'Location Required' }, status: :bad_request
    end
  end
end
