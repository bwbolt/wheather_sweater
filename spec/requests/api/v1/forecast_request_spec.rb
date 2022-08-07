require 'rails_helper'

RSpec.describe 'forcast', :vcr do
  describe 'happy path' do
    describe '#index' do
      it 'returns the forcast when given a valid location' do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        forecast = body[:data]

        expect(forecast).to have_key :id
        expect(forecast).to have_key :type
        expect(forecast).to have_key :attributes

        expect(forecast[:attributes]).to have_key :current_weather
        expect(forecast[:attributes]).to have_key :daily_weather
        expect(forecast[:attributes]).to have_key :hourly_weather

        current = forecast[:attributes][:current_weather]

        expect(current).to be_a Hash
        expect(current).to have_key :datetime
        expect(current[:datetime]).to be_a String
        expect(current).to have_key :sunrise
        expect(current[:sunrise]).to be_a String
        expect(current).to have_key :sunset
        expect(current[:sunset]).to be_a String
        expect(current).to have_key :temperature
        expect(current[:temperature]).to be_a Float
        expect(current).to have_key :feels_like
        expect(current[:feels_like]).to be_a Float
        expect(current).to have_key :humidity
        expect(current[:humidity]).to be_a Integer or be_a Float
        expect(current).to have_key :uvi
        expect(current[:uvi]).to be_a Float or be_a Integer
        expect(current).to have_key :visibility
        expect(current[:visibility]).to be_a Integer or be_a Float
        expect(current).to have_key :conditions
        expect(current[:conditions]).to be_a String
        expect(current).to have_key :icon
        expect(current[:icon]).to be_a String

        daily = forecast[:attributes][:daily_weather]

        expect(daily).to be_an Array
        expect(daily.length).to eq 5
        daily.each do |day|
          expect(day).to have_key :date
          expect(day[:date]).to be_a String
          expect(day).to have_key :sunrise
          expect(day[:sunrise]).to be_a String
          expect(day).to have_key :sunset
          expect(day[:sunset]).to be_a String
          expect(day).to have_key :max_temp
          expect(day[:max_temp]).to be_a Float
          expect(day).to have_key :min_temp
          expect(day[:min_temp]).to be_a Float
          expect(day).to have_key :conditions
          expect(day[:conditions]).to be_a String
          expect(day).to have_key :icon
          expect(day[:icon]).to be_a String
        end

        hourly = forecast[:attributes][:hourly_weather]

        expect(hourly).to be_an Array
        expect(hourly.length).to eq 8
        hourly.each do |hour|
          expect(hour).to have_key :time
          expect(hour[:time]).to be_a String
          expect(hour).to have_key :temperature
          expect(hour[:temperature]).to be_a Float
          expect(hour).to have_key :conditions
          expect(hour[:conditions]).to be_a String
          expect(hour).to have_key :icon
          expect(hour[:icon]).to be_a String
        end
      end
    end
  end
end
