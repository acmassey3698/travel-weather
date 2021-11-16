require 'rails_helper'

RSpec.describe BackgroundsFacade do
  describe 'class methods' do
    it '#search_image', :vcr do
      success = BackgroundsFacade.search_image("Denver,CO")
      expect(success).to be_a(Image)
      expect(success.author).to be_a String
      expect(success.image_url).to be_a String
      expect(success.location).to be_a String
      expect(success.profile).to be_a String
      expect(BackgroundsFacade.search_image("aewiorugnbiaowugbi")).to be_falsey
    end
  end
end
