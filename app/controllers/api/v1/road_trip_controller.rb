class Api::V1::RoadTripController < ApplicationController
  before_action :check_key

  def create
    if params[:origin].present? && params[:destination].present?
      road_trip = RoadTripFacade.new_trip(params[:origin], params[:destination])
    else
      return bad_request
    end

    if road_trip.present?
      render json: RoadTripSerializer.one_trip(road_trip)
    else
      return record_not_found
    end
  end

  private
  def check_key
    if params[:api_key].present?
      validate_key
    else
      unauthorized
    end
  end

  def validate_key
    users = User.validate_api_key(params[:api_key])
    if users.empty?
      unauthorized
    end
  end
end
