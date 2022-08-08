require 'rails_helper'

RSpec.describe 'MapquestService', :vcr do
  it 'retrieves data and parses response for a location' do
    parsed_json = MapquestService.get_coord('denver,co')

    expect(parsed_json).to be_a Hash
    expect(parsed_json[:results][0][:locations][0][:latLng][:lat]).to be_a Float
    expect(parsed_json[:results][0][:locations][0][:latLng][:lng]).to be_a Float
  end
end
