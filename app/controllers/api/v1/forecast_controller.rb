class Api::V1::ForecastController < ApplicationController
  def index
    coords = ForecastFacade.geocode_city(params[:location])
    forecast = ForecastFacade.city_weather(coords)

    render json: ForecastSerializer.city_forecast(forecast)
  end
end
