class Api::V1::ActivitiesController < ApplicationController

  def index
    if params[:destination].present?
      coords = ForecastFacade.geocode_city(params[:destination])
    else
      return bad_request
    end
    if coords.present?
      forecast  = ForecastFacade.city_weather(coords)
    else
      return record_not_found
    end
    activities = ActivitiesFacade.find_activities(forecast)

    render json: ActivitiesSerializer.destination_activities(params[:destination], forecast, activities)
  end
end
