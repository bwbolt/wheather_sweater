require 'rails_helper'

RSpec.describe 'YelpFacade', :vcr do
  describe 'happy path' do
    it 'makes services calls and returns a resturant' do
      resturant = YelpFacade.create_resturant('chinese', 'denver, co')

      expect(resturant).to be_a Resturant
      expect(resturant.name).to be_a String
      expect(resturant.address).to be_a String
    end
  end
  describe 'sad path' do
    it 'makes services calls and returns error if one exists' do
      resturant = YelpFacade.create_resturant('chinese', 'cow')

      expect(resturant).to eq('Could not execute search, try specifying a more exact location.')
    end
  end
end
