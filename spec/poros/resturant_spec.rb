require 'rails_helper'

RSpec.describe Resturant, :vcr do
  it 'exists with attributes' do
    resturant = YelpFacade.create_resturant('chinese', 'denver, co')

    expect(resturant).to be_a Resturant
    expect(resturant.name).to be_a String
    expect(resturant.address).to be_a String
  end

  it '#create_address' do
    parsed_json = YelpService.get_resturants('chinese', 'denver, co')

    resturant = YelpFacade.create_resturant('chinese', 'denver, co')

    address = resturant.format_address(parsed_json[:businesses][0])

    expect(address).to be_a String
  end
end
