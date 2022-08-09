require 'rails_helper'

RSpec.describe '/background', :vcr do
  it 'returns an image when given a location' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    image = body[:data]

    expect(image.keys).to contain_exactly(:id, :type, :attributes)

    expect(image[:id]).to eq(nil)
    expect(image[:type]).to eq('image')
    expect(image[:attributes]).to be_a Hash

    expect(image[:attributes]).to have_key :image

    expect(image[:attributes][:image]).to have_key :location
    expect(image[:attributes][:image]).to have_key :image_url
    expect(image[:attributes][:image]).to have_key :source
    expect(image[:attributes][:image]).to have_key :author
    expect(image[:attributes][:image]).to have_key :logo

    expect(image[:attributes][:image][:location]).to be_a String
    expect(image[:attributes][:image][:image_url]).to be_a String
    expect(image[:attributes][:image][:source]).to be_a String
    expect(image[:attributes][:image][:author]).to be_a String
    expect(image[:attributes][:image][:logo]).to be_a String
  end

  it 'renders 404 if no location is provided' do
    get '/api/v1/backgrounds'

    expect(response).to_not be_successful

    parsed_body = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_body).to have_key(:error)
    expect(parsed_body[:error]).to eq 'Location Required'
  end
end
