class RoadTripFacade
  def self.new_trip(origin, destination)
    response = MapService.get_directions(origin, destination)
    directions = JSON.parse(response.body, symbolize_names:true)
    if directions[:route][:distance] && directions[:route][:distance] > 0
      attributes = {
        start_city: origin,
        end_city: destination,
        travel_time: directions[:route][:formattedTime],
        forecast: destination_forecast(destination)
      }
      RoadTrip.new(attributes)
    elsif directions[:info][:messages].first == "We are unable to route with the given locations."
      attributes = {
        start_city: origin,
        end_city: destination,
        travel_time: "impossible route"
      }
      RoadTrip.new(attributes)
    else
      nil
    end
  end

  def self.destination_forecast(destination)
    coords = ForecastFacade.geocode_city(destination)
    forecast = ForecastFacade.city_weather(coords)
  end
end
