class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :forecast,
              :weather_at_eta

  def initialize(attrs)
    @start_city = attrs[:start_city]
    @end_city = attrs[:end_city]
    @travel_time = attrs[:travel_time]
    if attrs[:forecast].present?
      @weather_at_eta = arrival_weather(attrs[:forecast])
    else
      @weather_at_eta = {
        temperature: nil,
        conditions: nil
      }
    end
  end

  def arrival_weather(forecast)
    hours = travel_time[0..1].to_i - 1
    if hours < 48
      forecast.hourly_weather[hours]
    elsif hours == -1
      forecast.current_weather
    else
      multi_day(hours)
    end
  end

  def multi_day(hours)
    days = (hours/24) - 1
    forecast.daily_weather[days]
  end
end
