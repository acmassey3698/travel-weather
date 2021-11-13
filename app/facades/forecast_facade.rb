class ForecastFacade
  def self.geocode_city(city_state)
    response = MapService.geocode(city_state)
    parsed = JSON.parse(response.body, symbolize_names:true)
    parsed_locations = parsed[:results][0][:locations][0]

    {
      latitude: parsed_locations[:latLng][:lat],
      longitude: parsed_locations[:latLng][:lng]
    }
  end

  def self.city_weather(coords)
    response = WeatherService.weather_data(coords)
    parsed = JSON.parse(response.body, symbolize_names:true)

    attributes = {
      current_data: parsed[:current],
      daily_data: parsed[:daily],
      hourly_data: parsed[:hourly]
    }
    
    Forecast.new(attributes)
  end
end
