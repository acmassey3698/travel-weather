class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(attrs)
    @current_weather = {
      datetime: Time.at(attrs[:current_data][:dt]).utc.strftime("%a %b %e %T %Y"),
      sunrise: Time.at(attrs[:current_data][:sunrise]).utc.strftime("%a %b %e %T %Y"),
      sunset: Time.at(attrs[:current_data][:sunset]).utc.strftime("%a %b %e %T %Y"),
      temperature: attrs[:current_data][:temp],
      feels_like: attrs[:current_data][:feels_like],
      humidity: attrs[:current_data][:humidity],
      uvi: attrs[:current_data][:uvi],
      visibility: attrs[:current_data][:visibility],
      conditions: attrs[:current_data][:weather].first[:description],
      icon: attrs[:current_data][:weather].first[:icon]
    }

    @daily_weather =
    attrs[:daily_data].map do |day|
      {
        date: Time.at(day[:dt]).utc.strftime("%a %b %e %Y"),
        sunrise: Time.at(day[:sunrise]).utc.strftime("%a %b %e %T %Y"),
        sunset: Time.at(day[:sunset]).utc.strftime("%a %b %e %T %Y"),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end

    @hourly_weather =
    attrs[:hourly_data].map do |hour|
      {
        time: Time.at(hour[:dt]).utc.strftime('%T'),
        temperature: hour[:temp],
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end
  end
end
