require 'rails_helper'

RSpec.describe Shout, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:shouter).class_name('User') }
    it { is_expected.to have_many(:shout_users) }
    it { is_expected.to have_many(:users).through(:shout_users) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end

  describe '#callbacks' do
    describe '#after_create' do
      context 'with only new users' do
        let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

        it 'does associate users', :vcr do
          expect(shout.users.count).to eq(3)
        end

        it 'does fetch correct nicknames', :vcr do
          expect(shout.users.pluck(:nickname)).to eq(%w(pedro Krystal Foo_Bar))
        end
      end

      context 'with already created user' do
        before { create(:user, nickname: 'pedro') }

        let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

        it 'does associate users', :vcr do
          expect(shout.users.count).to eq(3)
        end

        it 'does fetch correct nicknames', :vcr do
          expect(shout.users.pluck(:nickname)).to eq(%w(pedro Krystal Foo_Bar))
        end
      end
    end
  end

  describe '#identified_users', :vcr do
    let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

    it 'does returns users', :vcr do
      expect(shout.identified_users).to eq(%w(pedro krystal foo_bar))
    end
  end
end
