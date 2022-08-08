require 'rails_helper'

RSpec.describe '/users', :vcr do
  describe '#create' do
    describe 'happy path' do
      it 'returns a user when user is authenticated via correct json body' do
        user_data = {
          "email": 'ac2d@example.com',
          "password": 'bryce',
          "password_confirmation": 'bryce'
        }
        post '/api/v1/users', params: user_data

        login = {
          "email": 'ac2d@example.com',
          "password": 'bryce'
        }
        post '/api/v1/sessions', params: login

        expect(response).to be_successful

        parsed_body = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_body).to have_key(:data)
        expect(parsed_body[:data]).to be_a Hash

        user = parsed_body[:data]

        expect(user).to have_key :id
        expect(user[:id]).to be_a String
        expect(user).to have_key :type
        expect(user[:type]).to eq('user')

        expect(user).to have_key :attributes

        expect(user[:attributes]).to have_key :email
        expect(user[:attributes][:email]).to be_a String

        expect(user[:attributes]).to have_key :api_key
        expect(user[:attributes][:api_key]).to be_a String
      end
    end

    describe 'sad path' do
      describe 'returns status 400 when unsuccessful' do
        it 'username/password incorrect' do
          user_data = {
            "email": 'ac2d@example.com',
            "password": 'bryce',
            "password_confirmation": 'bryce'
          }
          post '/api/v1/users', params: user_data

          login = {
            "email": 'ac2d@example.com',
            "password": 'Abryce'
          }
          post '/api/v1/sessions', params: login

          expect(response).to_not be_successful

          parsed_body = JSON.parse(response.body, symbolize_names: true)

          expect(parsed_body).to have_key(:error)
          expect(parsed_body[:error]).to eq 'Incorrect Email or Password'
        end
      end
    end
  end
end
