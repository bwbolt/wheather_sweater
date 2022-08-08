require 'rails_helper'

RSpec.describe 'YelpService', :vcr do
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
