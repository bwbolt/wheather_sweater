require 'rails_helper'

RSpec.describe 'OpenweatherFacade', :vcr do
  it 'makes services calls and returns a location objects' do
    location = MapquestFacade.get_coord('denver,co')
    forecast = OpenweatherFacade.create_forecast(location)

    expect(forecast).to be_a Forecast
  end
end
