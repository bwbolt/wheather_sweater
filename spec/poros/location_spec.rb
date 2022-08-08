require 'rails_helper'

RSpec.describe Location, :vcr do
  it 'exists with attributes' do
    data = MapquestService.get_coord('denver,co')

    location = Location.new(data)

    expect(location).to be_a Location
    expect(location.lat).to be_a Float
    expect(location.lng).to be_a Float
  end
end
