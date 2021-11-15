require 'rails_helper'

RSpec.describe ActivitiesFacade do
  describe 'class methods' do
    it '#find_activities', :vcr do
      coords = ForecastFacade.geocode_city('Denver,CO')
      forecast = ForecastFacade.city_weather(coords)

      expect(ActivitiesFacade.find_activities(forecast)).to be_an Array
      ActivitiesFacade.find_activities(forecast).each do |activity|
        expect(activity.title).to be_a String
        expect(activity.type).to be_a String
        expect(activity.participants).to be_a Numeric
        expect(activity.price).to be_a Numeric
      end

      expect(ActivitiesFacade.find_activities(forecast)[0].type).to eq("relaxation")
      expect(ActivitiesFacade.find_activities(forecast)[1].type).to eq("recreational")
    end

    it '#find_activities (really cold place)', :vcr do
      coords = ForecastFacade.geocode_city('Prospect Creek,AK')
      forecast = ForecastFacade.city_weather(coords)

      expect(ActivitiesFacade.find_activities(forecast)[0].type).to eq("relaxation")
      expect(ActivitiesFacade.find_activities(forecast)[1].type).to eq("cooking")
    end
  end
end
