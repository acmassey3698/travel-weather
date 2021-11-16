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
    @forecast = attrs[:forecast]
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
    hours = travel_time[0..1].to_i
    if hours < 48 && hours != -1
      forecast.hourly_weather[hours]
    else
      multi_day(hours)
    end
  end

  def multi_day(hours)
    days = (hours/24)
    {
      temperature: forecast.daily_weather[days][:max_temp],
      conditions: forecast.daily_weather[days][:conditions],
    }
  end
end
