require 'rails_helper'

RSpec.describe 'YelpService', :vcr do
  describe 'happy path' do
    it 'retrieves data and parses response for resturants' do
      parsed_json = YelpService.get_resturants('chinese', 'denver, co')

      expect(parsed_json).to be_a Hash
      expect(parsed_json).to have_key :businesses

      parsed_json[:businesses].each do |businesses|
        expect(businesses).to have_key :name
        expect(businesses).to have_key :location
        expect(businesses[:location]).to have_key :address1
      end
    end
  end
  describe 'sad path' do
    it 'returns error if location is not valid' do
      parsed_json = YelpService.get_resturants('chinese', 'cow')

      expect(parsed_json).to have_key :error
      expect(parsed_json[:error]).to have_key :description
      expect(parsed_json[:error][:description]).to eq 'Could not execute search, try specifying a more exact location.'
    end
  end
end
