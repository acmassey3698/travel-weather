class Forecast
  attr_reader :current_weather

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
  end
end
