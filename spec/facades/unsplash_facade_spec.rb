require 'rails_helper'

RSpec.describe 'UnsplashFacade', :vcr do
  describe 'happy paths' do
    it '#create_image' do
      image = UnsplashFacade.create_image('denver,co')

      expect(image).to be_a Image
    end
  end
end
