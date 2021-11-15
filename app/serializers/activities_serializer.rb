class ActivitiesSerializer
  def self.destination_activities(destination, forecast, activities)
    {
      "data": {
        "id": nil,
        "type": "activities",
        "attributes": {
          "destination": destination,
          "forecast": {
            "summary": forecast.current_weather[:conditions],
            "temperature": forecast.current_weather[:temperature]
          },
          "activities": activities.map do |activity|
            {
              "title": activity.title,
              "type": activity.type,
              "participants": activity.participants,
              "price": activity.price,
            }
          end
        }
      }
    }
  end
end
