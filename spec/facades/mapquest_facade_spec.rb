require 'rails_helper'

RSpec.describe 'MapquestFacade', :vcr do
  describe 'happy paths' do
    it '#get_coord' do
      location = MapquestFacade.get_coord('denver,co')

      expect(location).to be_a Location
    end

    it '#get_travel_time' do
      time = MapquestFacade.get_travel_time('New York, NY', 'Pensacola, Fl')

      expect(time).to be_a String
    end
  end

  describe 'sad paths' do
    it '#get_travel_time' do
      time = MapquestFacade.get_travel_time('New York, NY', 'Japan')

      expect(time).to be_a String
      expect(time).to eq 'impossible route'
    end
  end
end
