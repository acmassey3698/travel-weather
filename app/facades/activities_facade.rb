class ActivitiesFacade

  def self.find_activities(forecast)
    activity1 = BoredService.activity
    current_temp = forecast.current_weather[:temperature]

    if current_temp >= 60
      activity2 = BoredService.activity("recreational")
    elsif current_temp >= 50 && current_temp < 60
      activity2 = BoredService.activity("busywork")
    else
      activity2 = BoredService.activity("cooking")
    end

    activities = [activity1, activity2]

    activities.map do |activity|
      attributes = JSON.parse(activity.body, symbolize_names:true)
      Activity.new(attributes)
    end
  end
end
