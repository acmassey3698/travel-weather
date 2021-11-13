require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    it '#geocode_city', :vcr do
      expect(ForecastFacade.geocode_city("Denver,CO")).to have_key(:latitude)
      expect(ForecastFacade.geocode_city("Denver,CO")).to have_key(:longitude)
    end

    it '#city_weather', :vcr do
      coords = ForecastFacade.geocode_city('Denver,CO')

      expect(ForecastFacade.city_weather(coords)).to be_a Forecast
    end
  end
end
