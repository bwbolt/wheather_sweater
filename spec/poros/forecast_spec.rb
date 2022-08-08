require 'rails_helper'

RSpec.describe Forecast, :vcr do
  it 'exists with attributes' do
    location = MapquestFacade.get_coord('denver,co')
    parsed_json = OpenweatherService.get_forecast(location)

    forecast = Forecast.create_forecast(parsed_json)

    expect(forecast).to be_a Forecast
    expect(forecast.id).to eq nil
    expect(forecast.current_weather).to be_a CurrentWeather
    expect(forecast.hourly_weather).to be_an Array
    expect(forecast.hourly_weather).to all be_a HourlyWeather
    expect(forecast.daily_weather).to be_an Array
    expect(forecast.daily_weather).to all be_a DailyWeather
  end
end
