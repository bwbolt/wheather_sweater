require 'rails_helper'

RSpec.describe Image, :vcr do
  it 'exists with attributes' do
    parsed_json = UnsplashService.get_image('denver, co')

    image = Image.new(parsed_json, 'denver, co')

    expect(image).to be_a Image

    expect(image.id).to eq(nil)
    expect(image.image).to be_a Hash
  end
end
