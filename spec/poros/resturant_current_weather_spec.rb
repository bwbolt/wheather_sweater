require 'rails_helper'

RSpec.describe ResturantCurrentWeather, :vcr do
  it 'exists with attributes' do
    coord = MapquestFacade.get_coord('denver, co')
    forecast = OpenweatherFacade.create_forecast(coord)
    rcw = ResturantCurrentWeather.new(forecast.current_weather)

    expect(rcw).to be_a ResturantCurrentWeather
    expect(rcw.summary).to be_a String
    expect(rcw.temperature).to be_a String
  end
end
