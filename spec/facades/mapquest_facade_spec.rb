require 'rails_helper'

RSpec.describe 'MapquestFacade', :vcr do
  it 'makes services calls and returns a location objects' do
    location = MapquestFacade.get_coord('denver,co')

    expect(location).to be_a Location
  end
end
