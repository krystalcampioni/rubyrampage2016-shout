require 'rails_helper'

RSpec.describe Shout, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:shouter).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end

  describe '#identified_users' do
    let!(:shout) { create(:shout, message: 'Hi @pedro, @krystal @foo_bar ????') }

    it 'does returns users' do
      expect(shout.identified_users).to eq(['@pedro', '@krystal', '@foo_bar'])
    end
  end
end
