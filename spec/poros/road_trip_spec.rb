require 'rails_helper'

RSpec.describe RoadTrip, :vcr do
  it 'exists with attributes' do
    weather_at_eta = {
      "temperature": 78.37,
      "conditions": 'scattered clouds'
    }

    road_trip = RoadTrip.new('denver,co', 'New York, NY', '4', weather_at_eta)

    expect(road_trip).to be_a RoadTrip

    expect(road_trip.id).to eq nil
    expect(road_trip.start_city).to be_a String
    expect(road_trip.start_city).to eq 'denver,co'
    expect(road_trip.end_city).to be_a String
    expect(road_trip.end_city).to eq 'New York, NY'
    expect(road_trip.travel_time).to be_a String
    expect(road_trip.weather_at_eta).to be_a Hash
  end

  it 'returns even with impossible route' do
    weather_at_eta = nil
    travel_time = 'impossible route'

    road_trip = RoadTrip.new('denver,co', 'Hawaii', travel_time, weather_at_eta)

    expect(road_trip).to be_a RoadTrip

    expect(road_trip.id).to eq nil
    expect(road_trip.start_city).to be_a String
    expect(road_trip.start_city).to eq 'denver,co'
    expect(road_trip.end_city).to be_a String
    expect(road_trip.end_city).to eq 'Hawaii'
    expect(road_trip.travel_time).to be_a String
    expect(road_trip.travel_time).to eq 'impossible route'
    expect(road_trip.weather_at_eta).to eq nil
  end
end
