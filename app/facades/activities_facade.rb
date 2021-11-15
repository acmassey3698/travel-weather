class ActivitiesFacade

  def self.find_activities(forecast)
    relaxation_activity = BoredService.relaxation_activity
    current_temp = forecast.current_weather[:temperature]

    if current_temp >= 60
      second_activity = BoredService.weather_dependent("recreational")
    elsif current_temp >= 50 && current_temp < 60
      second_activity = BoredService.weather_dependent("busywork")
    else
      second_activity = BoredService.weather_dependent("cooking")
    end

    activities = [relaxation_activity, second_activity]

    activities.map do |activity|
      attributes = JSON.parse(activity.body, symbolize_names:true)
      Activity.new(attributes)
    end
  end
end
