require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    it '#geocode_city', :vcr do
      expect(ForecastFacade.geocode_city("Denver,CO")).to have_key(:latitude)
      expect(ForecastFacade.geocode_city("Denver,CO")).to have_key(:longitude)
    end

    it '#city_weather', :vcr do
      coords = ForecastFacade.geocode_city('Denver,CO')

      result = ForecastFacade.city_weather(coords)
      expect(result).to be_a Forecast
      expect(result.current_weather).to be_a Hash
      expect(result.current_weather).to be_a Hash
      expect(result.current_weather).to have_key :datetime
      expect(result.current_weather).to have_key :sunrise
      expect(result.current_weather).to have_key :sunset
      expect(result.current_weather).to have_key :temperature
      expect(result.current_weather).to have_key :feels_like
      expect(result.current_weather).to have_key :humidity
      expect(result.current_weather).to have_key :uvi
      expect(result.current_weather).to have_key :visibility
      expect(result.current_weather).to have_key :conditions
      expect(result.current_weather).to have_key :icon

      expect(result.daily_weather).to be_an Array
      result.daily_weather.each do |r|
        expect(r).to have_key :date
        expect(r).to have_key :sunrise
        expect(r).to have_key :sunset
        expect(r).to have_key :max_temp
        expect(r).to have_key :min_temp
        expect(r).to have_key :conditions
        expect(r).to have_key :icon
      end

      expect(result.hourly_weather).to be_an Array
      result.hourly_weather.each do |r|
        expect(r).to have_key :time
        expect(r).to have_key :temperature
        expect(r).to have_key :conditions
        expect(r).to have_key :icon
      end
    end
  end
end
