require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }
    it 'username is required' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'email is required' do
      user.email = nil
      expect(user).to_not be_valid
    end
  end
end
