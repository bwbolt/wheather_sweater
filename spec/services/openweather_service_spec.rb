require 'rails_helper'

RSpec.describe 'OpenweatherService', :vcr do
  describe 'happy paths' do
    it '#get_forecast' do
      location = MapquestFacade.get_coord('denver,co')
      parsed_json = OpenweatherService.get_forecast(location)

      expect(parsed_json).to be_a Hash
    end
  end
end
