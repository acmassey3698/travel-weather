class Api::V1::ForecastController < ApplicationController
  def index
    coords = GeocodingService.get_coordinates(params[:location])
    @weather = WeatherFacade.city_weather(coords)
  end
end
