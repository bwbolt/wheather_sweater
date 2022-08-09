require 'rails_helper'

RSpec.describe 'UnsplashService', :vcr do
  describe 'happy paths' do
    it '#get_image' do
      parsed_json = UnsplashService.get_image('denver,co')

      expect(parsed_json).to be_a Hash
    end
  end
end
