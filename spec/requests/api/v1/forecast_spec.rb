require 'rails_helper'

RSpec.describe '/forcast', :vcr do
  describe 'happy path' do
    describe '#index' do
      it 'returns the forcast when given a valid location' do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        forecast = body[:data]

        expect(forecast.keys).to contain_exactly(:id, :type, :attributes)
        expect(forecast[:id]).to eq(nil)
        expect(forecast[:type]).to eq('forecast')
        expect(forecast[:attributes]).to be_a Hash

        expect(forecast[:attributes]).to have_key :current_weather
        expect(forecast[:attributes]).to have_key :daily_weather
        expect(forecast[:attributes]).to have_key :hourly_weather

        expect(forecast[:attributes]).to_not have_key :minutely_weather
        expect(forecast[:attributes]).to_not have_key :weekly_weather

        current = forecast[:attributes][:current_weather]
        expect(current).to be_a Hash
        expect(current.keys).to contain_exactly(:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity,
                                                :uvi, :visibility, :conditions, :icon)

        expect(current[:datetime]).to be_a String
        expect(current[:sunrise]).to be_a String
        expect(current[:sunset]).to be_a String
        expect(current[:temperature]).to be_a Float
        expect(current[:feels_like]).to be_a Float
        expect(current[:humidity]).to be_a Integer or be_a Float
        expect(current[:uvi]).to be_a Float or be_a Integer
        expect(current[:visibility]).to be_a Integer or be_a Float
        expect(current[:conditions]).to be_a String
        expect(current[:icon]).to be_a String

        daily = forecast[:attributes][:daily_weather]

        expect(daily).to be_an Array
        expect(daily.length).to eq 5
        daily.each do |day|
          expect(day).to be_a Hash
          expect(day.keys).to contain_exactly(:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon)
          expect(day[:date]).to be_a String
          expect(day[:sunrise]).to be_a String
          expect(day[:sunset]).to be_a String
          expect(day[:max_temp]).to be_a Float
          expect(day[:min_temp]).to be_a Float
          expect(day[:conditions]).to be_a String
          expect(day[:icon]).to be_a String
        end

        hourly = forecast[:attributes][:hourly_weather]

        expect(hourly).to be_an Array
        expect(hourly.length).to eq 8
        hourly.each do |hour|
          expect(hour).to be_a Hash
          expect(hour.keys).to contain_exactly(:time, :temperature, :conditions, :icon)
          expect(hour[:time]).to be_a String
          expect(hour[:temperature]).to_not be_a String
          expect(hour[:conditions]).to be_a String
          expect(hour[:icon]).to be_a String
        end
      end
    end
  end
  describe 'sad path' do
    describe '#index' do
      it 'renders 404 if no location is provided' do
        get '/api/v1/forecast'

        expect(response).to_not be_successful
      end
    end
  end
end
