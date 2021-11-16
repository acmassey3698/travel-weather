class RoadTripFacade

  def self.new_trip(origin, destination)
    response = MapService.get_directions(origin, destination)
    directions = JSON.parse(response.body, symbolize_names:true)

    if directions[:route][:distance] && directions[:route][:distance] > 0
      valid_trip(origin, destination, directions)
    elsif directions[:info][:messages].first == "We are unable to route with the given locations."
      invalid_trip(origin, destination, directions)
    else
      nil
    end
  end

  def self.valid_trip(origin, destination, directions)
    attributes = {
      start_city: origin,
      end_city: destination,
      travel_time: directions[:route][:formattedTime],
      forecast: destination_forecast(destination)
    }
    RoadTrip.new(attributes)
  end

  def self.invalid_trip(origin, destination, directions)
    attributes = {
      start_city: origin,
      end_city: destination,
      travel_time: "impossible route"
    }
    RoadTrip.new(attributes)
  end

  def self.destination_forecast(destination)
    coords = ForecastFacade.geocode_city(destination)
    forecast = ForecastFacade.city_weather(coords)
  end
end
