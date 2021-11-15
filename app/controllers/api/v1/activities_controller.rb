class Api::V1::ActivitiesController < ApplicationController

  def index
    coords    = ForecastFacade.geocode_city(params[:destination])
    forecast  = ForecastFacade.city_weather(coords)
    activites = ActivitiesFacade.find_activities(forecast)
  end
end
