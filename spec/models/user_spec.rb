require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_confirmation_of(:password).on(:create)}
  end

  describe 'class methods' do
    it '#validate api_key' do
      user1 = User.create!(
        email: 'python@python.com',
        password: 'python',
        password_confirmation: 'python',
        api_key: SecureRandom.hex
      )

      expect(User.validate_api_key(user1.api_key).first).to eq(user1)
    end

    it '#validate_api_key when there are no users' do
      expect(User.validate_api_key("naofnoewno")).to be_empty
    end
  end
end
