class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.present?
      road_trip = RoadTrip.new(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { error: 'Api Key Incorrect or Missing' }, status: :unauthorized
    end
  end
end