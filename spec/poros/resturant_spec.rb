require 'rails_helper'

RSpec.describe Resturant, :vcr do
  it 'exists with attributes' do
    resturant = YelpFacade.create_resturant('chinese', 'denver, co')

    expect(resturant).to be_a Resturant
    expect(resturant.name).to be_a String
    expect(resturant.address).to be_a String
  end
end
