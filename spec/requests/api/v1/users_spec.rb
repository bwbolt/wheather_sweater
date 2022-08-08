require 'rails_helper'

RSpec.describe '/users', :vcr do
  describe '#create' do
    describe 'happy path' do
      it 'creates a user when appropriate requirements met and returns a json response' do
        body = {
          "email": 'ac2d@example.com',
          "password": 'bryce',
          "password_confirmation": 'bryce'
        }

        post '/api/v1/users', params: body

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
        it "passwords don't match" do
          body = {
            "email": 'ac2d@example.com',
            "password": 'bryce',
            "password_confirmation": 'abryce'
          }

          post '/api/v1/users', params: body

          expect(response).to_not be_successful

          parsed_body = JSON.parse(response.body, symbolize_names: true)

          expected = { password_confirmation: ["doesn't match Password"] }

          expect(parsed_body).to eq(expected)
        end
        it 'email already taken' do
          body = {
            "email": 'ac2d@example.com',
            "password": 'bryce',
            "password_confirmation": 'bryce'
          }
          post '/api/v1/users', params: body

          body = {
            "email": 'ac2d@example.com',
            "password": 'abryce',
            "password_confirmation": 'abryce'
          }
          post '/api/v1/users', params: body

          expect(response).to_not be_successful

          parsed_body = JSON.parse(response.body, symbolize_names: true)

          expected = { email: ['has already been taken'] }

          expect(parsed_body).to eq(expected)
        end
        it 'missing a email' do
          body = {
            "password": 'abryce',
            "password_confirmation": 'abryce'
          }

          post '/api/v1/users', params: body

          expect(response).to_not be_successful

          parsed_body = JSON.parse(response.body, symbolize_names: true)

          expected = { email: ["can't be blank"] }

          expect(parsed_body).to eq(expected)
        end
      end
    end
  end
end
