require 'rails_helper'

RSpec.describe HourlyWeather, :vcr do
  it 'exists with attributes' do
    location = MapquestFacade.get_coord('denver,co')
    parsed_json = OpenweatherService.get_forecast(location)

    hourly = HourlyWeather.new(parsed_json[:hourly][0])

    expect(hourly).to be_a HourlyWeather

    expect(hourly.time).to be_a String
    expect(hourly.temperature).to be_a Float
    expect(hourly.conditions).to be_a String
    expect(hourly.icon).to be_a String
  end
end
