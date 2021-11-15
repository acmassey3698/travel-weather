class RoadTripFacade
  def self.new_trip(origin, destination)
    response = MapService.get_directions(origin, destination)
    directions = JSON.parse(response.body, symbolize_names:true)
    attributes = {
      start_city: origin,
      end_city: destination,
      travel_time: directions[:route][:formattedTime],
      forecast: destination_forecast(destination)
    }
    
    RoadTrip.new(attributes)
  end

  def self.destination_forecast(destination)
    coords = ForecastFacade.geocode_city(destination)
    forecast = ForecastFacade.city_weather(coords)
  end
end
