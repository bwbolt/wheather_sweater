require 'rails_helper'

RSpec.describe DailyWeather, :vcr do
  it 'exists with attributes' do
    location = MapquestFacade.get_coord('denver,co')
    parsed_json = OpenweatherService.get_forecast(location)

    daily = DailyWeather.new(parsed_json[:daily][0])

    expect(daily).to be_a DailyWeather

    expect(daily.date).to be_a String
    expect(daily.sunrise).to be_a Time
    expect(daily.sunset).to be_a Time
    expect(daily.max_temp).to be_a Float
    expect(daily.min_temp).to be_a Float
    expect(daily.conditions).to be_a String
    expect(daily.icon).to be_a String
  end
end
