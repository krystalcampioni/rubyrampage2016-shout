require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:shouts) }
    it { is_expected.to have_many(:sent_shouts).class_name('Shout').with_foreign_key(:shouter_id) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_uniqueness_of(:nickname) }
    it { is_expected.to validate_presence_of(:profile_image_url) }
  end

  describe '.find_or_create_from_auth_hash' do
    let(:twitter_hash) do
      { provider: 'twitter',
        uid: '12354567',
        info: {
          nickname: 'johnfuu',
          name: 'John Lord',
          image: 'https://example.com/image'
        } }
    end

    it 'create a new user' do
      expect do
        User.find_or_create_from_auth_hash(twitter_hash)
      end.to change { User.count }
    end

    context 'with a existing user' do
      let!(:user) { create(:user, nickname: 'johnfuu') }

      it 'not create a new user' do
        expect do
          User.find_or_create_from_auth_hash(twitter_hash)
        end.to_not change { User.count }
      end

      it 'update user name and images' do
        User.find_or_create_from_auth_hash(twitter_hash)
        expect(user.reload.name).to eq('John Lord')
        expect(user.reload.profile_image_url).to eq('https://example.com/image')
      end
    end
  end
end
