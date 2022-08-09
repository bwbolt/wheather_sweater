require 'rails_helper'

RSpec.describe RoadTrip, :vcr do
  it 'exists with attributes' do
    road_trip = RoadTrip.new('denver,co', 'New York, NY')

    expect(road_trip).to be_a RoadTrip

    expect(road_trip.id).to eq nil
    expect(road_trip.start_city).to be_a String
    expect(road_trip.start_city).to eq 'denver,co'
    expect(road_trip.end_city).to be_a String
    expect(road_trip.end_city).to eq 'New York, NY'
    expect(road_trip.travel_time).to be_a String
    expect(road_trip.weather_at_eta).to be_a ForecastAtArrival
  end
end
