class Api::V1::ActivitiesController < ApplicationController

  def index
    coords    = ForecastFacade.geocode_city(params[:destination])
    forecast  = ForecastFacade.city_weather(coords)
    activities = ActivitiesFacade.find_activities(forecast)

    render json: ActivitiesSerializer.destination_activities(params[:destination], forecast, activities)
  end
end
