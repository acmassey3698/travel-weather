require 'rails_helper'

RSpec.describe MapService do
  describe 'class methods' do
    it '#geocode', :vcr do
      response = MapService.geocode('Denver,CO')
      parsed = JSON.parse(response.body, symbolize_names:true)

      expect(parsed).to be_a Hash
      expect(parsed).to have_key :results
      expect(parsed[:results][0][:locations][0][:latLng][:lat]).to be_truthy
      expect(parsed[:results][0][:locations][0][:latLng][:lng]).to be_truthy
    end

    it '#get_directions', :vcr do
      response = MapService.get_directions('Denver,CO', 'Portland,OR')
      parsed = JSON.parse(response.body, symbolize_names:true)
      expect(parsed).to be_a Hash
      expect(parsed).to have_key :route
      expect(parsed[:route]).to have_key :distance
      expect(parsed[:route]).to have_key :formattedTime
    end

    it '#get_directions sad_path', :vcr do
      response = MapService.get_directions('Denver,CO', 'London,UK')
      parsed = JSON.parse(response.body, symbolize_names:true)

      expect(parsed).to be_a Hash
      expect(parsed).to have_key :info
      expect(parsed[:info][:messages]).to be_an Array
    end
  end
end
