require 'rails_helper'

RSpec.describe 'OpenweatherService', :vcr do
  it 'retrieves data and parses response for a location' do
    location = MapquestFacade.get_coord('denver,co')
    parsed_json = OpenweatherService.get_forecast(location)

    expect(parsed_json).to be_a Hash
  end
end
