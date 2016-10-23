require 'rails_helper'

RSpec.describe Shout, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:shouter).class_name('User') }
    it { is_expected.to have_and_belong_to_many(:users) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end

  describe '#callbacks' do
    describe '#after_create' do
      let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

      it 'does associate users', :vcr do
        expect(shout.users.count).to eq(3)
      end

      it 'does fetch correct nicknames', :vcr do
        expect(shout.users.pluck(:nickname)).to eq(%w(pedro Krystal Foo_Bar))
      end
    end
  end

  describe '#identified_users' do
    let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

    it 'does returns users', :vcr do
      expect(shout.identified_users).to eq(['@pedro', '@krystal', '@foo_bar'])
    end
  end
end
