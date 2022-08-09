require 'rails_helper'

RSpec.describe '/road_trip', :vcr do
  describe 'happy path' do
    describe '#create' do
      it 'returns a roadtrip when given valid key and destination' do
        user_data = {
          "email": 'ac2d@example.com',
          "password": 'bryce',
          "password_confirmation": 'bryce'
        }
        post '/api/v1/users', params: user_data

        parsed_user_body = JSON.parse(response.body, symbolize_names: true)
        api_key = parsed_user_body[:data][:attributes][:api_key]

        data = {
          "origin": 'New York, NY',
          "destination": 'Los Angeles,CA',
          "api_key": api_key
        }

        post '/api/v1/road_trip', params: data

        expect(response).to be_successful

        parsed_body = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_body).to have_key(:data)
        expect(parsed_body[:data]).to be_a Hash

        road_trip = parsed_body[:data]

        expect(road_trip).to have_key :id
        expect(road_trip).to have_key :type
        expect(road_trip[:type]).to eq('road_trip')

        expect(road_trip).to have_key :attributes

        expect(road_trip[:attributes]).to have_key :start_city
        expect(road_trip[:attributes][:start_city]).to be_a String

        expect(road_trip[:attributes]).to have_key :end_city
        expect(road_trip[:attributes][:end_city]).to be_a String

        expect(road_trip[:attributes]).to have_key :travel_time
        expect(road_trip[:attributes][:travel_time]).to be_a String

        expect(road_trip[:attributes]).to have_key :weather_at_eta
        expect(road_trip[:attributes][:weather_at_eta]).to be_a Hash

        expect(road_trip[:attributes][:weather_at_eta]).to have_key :temperature
        expect(road_trip[:attributes][:weather_at_eta]).to have_key :conditions
        expect(road_trip[:attributes][:weather_at_eta][:conditions]).to be_a String
      end
    end
  end

  describe 'sad path' do
    describe 'returns status 400 when unsuccessful' do
      it 'api key incorrect' do
        user_data = {
          "email": 'ac2d@example.com',
          "password": 'bryce',
          "password_confirmation": 'bryce'
        }
        post '/api/v1/users', params: user_data

        parsed_user_body = JSON.parse(response.body, symbolize_names: true)
        api_key = parsed_user_body[:data][:attributes][:api_key]

        data = {
          "origin": 'New York, NY',
          "destination": 'Los Angeles,CA',
          "api_key": 'notcorrect'
        }

        post '/api/v1/road_trip', params: data

        expect(response).to_not be_successful

        parsed_body = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_body).to have_key(:error)
        expect(parsed_body[:error]).to eq 'Api Key Incorrect or Missing'
      end
    end
  end
end
