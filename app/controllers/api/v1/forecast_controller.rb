class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      coords = ForecastFacade.geocode_city(params[:location])
    else
      return bad_request
    end
    if coords.present?
      forecast = ForecastFacade.city_weather(coords)
    else
      return record_not_found
    end
    render json: ForecastSerializer.city_forecast(forecast)
  end
end
