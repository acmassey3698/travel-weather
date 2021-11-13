require 'rails_helper'

RSpec.describe Forecast do
  it 'exists with attributes', :vcr do
    coords = {
      latitude: 33.44,
      longitude: -94.04
    }

    forecast = ForecastFacade.city_weather(coords)

    expect(forecast.current_weather).to be_a Hash
    expect(forecast.daily_weather).to be_a Array
    expect(forecast.hourly_weather).to be_a Array
  end
end
