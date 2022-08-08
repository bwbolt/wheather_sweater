require 'rails_helper'

RSpec.describe Munchie, :vcr do
  it 'exists with attributes' do
    munchie = Munchie.new('chinese', 'denver, co')

    expect(munchie).to be_a Munchie
    expect(munchie.id).to eq(nil)
    expect(munchie.destination_city).to be_a String
    expect(munchie.forecast).to be_a ResturantCurrentWeather
    expect(munchie.resturant).to be_a Resturant
  end

  it '#current_forecast' do
    munchie = Munchie.new('chinese', 'denver, co')
    current_forecast = munchie.current_forecast('denver, co')

    expect(current_forecast).to be_a ResturantCurrentWeather
  end
end
