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
  end
end
