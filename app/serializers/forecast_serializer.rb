class ForecastSerializer

  def self.city_forecast(forecast)
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            datetime: forecast.current_weather[:datetime],
            sunrise: forecast.current_weather[:sunrise],
            sunset: forecast.current_weather[:sunset],
            temperature: forecast.current_weather[:temperature],
            feels_like: forecast.current_weather[:feels_like],
            humidity: forecast.current_weather[:humidity],
            uvi: forecast.current_weather[:uvi],
            visibility: forecast.current_weather[:visibility],
            conditions: forecast.current_weather[:conditions],
            icon: forecast.current_weather[:icon]
          },
          "daily_weather": forecast.daily_weather[1..5].map do |day|
            {
              date: day[:date],
              sunrise: day[:sunrise],
              sunset: day[:sunset],
              max_temp: day[:max_temp],
              min_temp: day[:min_temp],
              conditions: day[:conditions],
              icon: day[:icon]
            }
          end,
          "hourly_weather": forecast.hourly_weather[1..8].map do |hour|
            {
              time: hour[:time],
              temperature: hour[:temperature],
              conditions: hour[:conditions],
              icon: hour[:icon]
            }
          end
        }
      }
    }
  end
end
