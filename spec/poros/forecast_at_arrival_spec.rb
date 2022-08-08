require 'rails_helper'

RSpec.describe ForecastAtArrival, :vcr do
  describe 'happy path' do
    it '#new' do
      location = MapquestFacade.get_coord('denver,co')
      parsed_json = OpenweatherService.get_forecast(location)

      forecast = ForecastAtArrival.new(parsed_json, 2)

      expect(forecast).to be_a ForecastAtArrival
      expect(forecast.conditions).to be_a String
      expect(forecast.temperature).to_not be_a String
    end

    it '#set_temp' do
      location = MapquestFacade.get_coord('denver,co')
      parsed_json = OpenweatherService.get_forecast(location)
      forecast = ForecastAtArrival.new(parsed_json, 50)

      temp = forecast.set_temp(parsed_json, 50)

      expect(temp).to be_a Float
    end

    it '#set_conditions' do
      location = MapquestFacade.get_coord('denver,co')
      parsed_json = OpenweatherService.get_forecast(location)
      forecast = ForecastAtArrival.new(parsed_json, 50)

      conditions = forecast.set_conditions(parsed_json, 50)

      expect(conditions).to be_a String
    end
  end
end
