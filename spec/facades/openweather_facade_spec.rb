require 'rails_helper'

RSpec.describe 'OpenweatherFacade', :vcr do
  describe 'happy path' do
    it '#create_forcast' do
      location = MapquestFacade.get_coord('denver,co')
      forecast = OpenweatherFacade.create_forecast(location)

      expect(forecast).to be_a Forecast
    end

    it '#create_forecast_at_arrival' do
      location = MapquestFacade.get_coord('denver,co')
      forecast = OpenweatherFacade.create_forecast_at_arrival(location, 2)

      expect(forecast).to be_a ForecastAtArrival
    end

    it '#create_weather_at_eta' do
      forecast = OpenweatherFacade.create_weather_at_eta('denver,co', '1:2:3')

      expect(forecast).to be_a ForecastAtArrival
    end
  end
end
