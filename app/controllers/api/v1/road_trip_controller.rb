class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip = RoadTripFacade.new_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.one_trip(road_trip)
  end
end
