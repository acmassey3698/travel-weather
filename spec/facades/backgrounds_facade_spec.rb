require 'rails_helper'

RSpec.describe BackgroundsFacade do
  describe 'class methods' do
    it '#search_image', :vcr do
      expect(BackgroundsFacade.search_image("Denver,CO")).to be_a(Image)
      expect(BackgroundsFacade.search_image("aewiorugnbiaowugbi")).to be_falsey
    end
  end
end
