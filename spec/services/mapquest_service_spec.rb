require 'rails_helper'

RSpec.describe 'MapquestService', :vcr do
  describe 'happy paths' do
    it '#get_coord' do
      parsed_json = MapquestService.get_coord('denver,co')

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(parsed_json[:results][0][:locations][0][:latLng][:lng]).to be_a Float
    end
    it '#get_travel_time' do
      parsed_json = MapquestService.get_travel_time('pensacola, fl', 'chesapeake, va')

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:route][:formattedTime]).to be_a String
    end
  end
end
