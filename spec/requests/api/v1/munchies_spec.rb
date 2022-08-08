require 'rails_helper'

RSpec.describe '/munchies', :vcr do
  describe 'happy path' do
    describe '#create' do
      it 'returns the destination city/ resturant info/ and current forecast' do
        get '/api/v1/munchies?location=denver,co&food=chinese'

        expect(response).to be_successful

        body = JSON.parse(response.body, symbolize_names: true)

        munchie = body[:data]

        expect(munchie.keys).to contain_exactly(:id, :type, :attributes)

        expect(munchie[:id]).to eq(nil)
        expect(munchie[:type]).to eq('munchie')
        expect(munchie[:attributes]).to be_a Hash

        expect(munchie[:attributes].keys).to contain_exactly(:destination_city, :forecast, :resturant)

        expect(munchie[:attributes][:destination_city]).to be_a String

        expect(munchie[:attributes][:forecast]).to be_a Hash
        expect(munchie[:attributes][:forecast].keys).to contain_exactly(:summary, :temperature)

        expect(munchie[:attributes][:forecast][:summary]).to be_a String
        expect(munchie[:attributes][:forecast][:temperature]).to be_a String

        expect(munchie[:attributes][:resturant]).to be_a Hash
        expect(munchie[:attributes][:resturant].keys).to contain_exactly(:name, :address)

        expect(munchie[:attributes][:resturant][:name]).to be_a String
        expect(munchie[:attributes][:resturant][:address]).to be_a String
      end
    end
  end

  describe 'sad path' do
    describe '#create' do
      it 'returns error if no location is provided' do
        get '/api/v1/munchies?food=chinese'

        expect(response).to_not be_successful

        parsed_body = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_body).to have_key(:error)
        expect(parsed_body[:error]).to eq 'Location Required'
      end

      it 'returns serialized response without resturant if location isnt up to standard' do
        get '/api/v1/munchies?location=cow&food=chinese'

        expect(response).to be_successful

        body = JSON.parse(response.body, symbolize_names: true)

        munchie = body[:data]

        expect(munchie.keys).to contain_exactly(:id, :type, :attributes)

        expect(munchie[:id]).to eq(nil)
        expect(munchie[:type]).to eq('munchie')
        expect(munchie[:attributes]).to be_a Hash

        expect(munchie[:attributes].keys).to contain_exactly(:destination_city, :forecast, :resturant)

        expect(munchie[:attributes][:destination_city]).to be_a String

        expect(munchie[:attributes][:forecast]).to be_a Hash
        expect(munchie[:attributes][:forecast].keys).to contain_exactly(:summary, :temperature)

        expect(munchie[:attributes][:forecast][:summary]).to be_a String
        expect(munchie[:attributes][:forecast][:temperature]).to be_a String

        expect(munchie[:attributes][:resturant]).to be_a String
        expect(munchie[:attributes][:resturant]).to eq 'Could not execute search, try specifying a more exact location.'
      end
    end
  end
end
