require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'instance methods' do
    it '#generate_api_key' do
      user = User.new({
                        "email": 'whatever@example.com',
                        "password": 'password',
                        "password_confirmation": 'password'
                      })
      expect(user.api_key).to eq nil

      user.generate_api_key

      expect(user.api_key).to_not eq nil
    end
  end
end
