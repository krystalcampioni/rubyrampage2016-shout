require 'rails_helper'

RSpec.describe CreateOrDeleteReaction do
  let(:shout) { create(:shout) }
  let(:service) { CreateOrDeleteReaction.new(shout, emoji, emojis_from_cookie) }

  context 'with no emoji previously stored' do
    let(:emoji) { '👻' }
    let(:emojis_from_cookie) { nil }

    it 'creates a new reaction' do
      expect { service.run }.to change { shout.reactions.count }.by(1)
      expect(shout.reactions.first.counter).to eq 1
    end

    it 'returns the string to store in the cookie correctly' do
      expect(service.emojis_to_store).to eq 'ghost'
    end
  end

  context 'storing another reaction from the same user' do
    let(:emoji) { '🤖' }
    let(:ghost_emoji) { '👻' }
    let(:emojis_from_cookie) { 'ghost' }

    before { shout.reactions.create!(emoji: ghost_emoji, counter: 1) }

    it 'returns the string to store in the cookie correctly' do
      expect(service.emojis_to_store).to eq 'ghost,robot'
    end

    it 'returns emojis in user reactions correctly' do
      expect(service.user_reactions).to eq [ghost_emoji, emoji]
    end
  end

  context 'with an emoji previously stored' do
    let(:emoji) { '👻' }
    let(:emojis_from_cookie) { 'ghost' }

    before { shout.reactions.create!(emoji: emoji, counter: 2) }

    it 'removes a reaction' do
      expect { service.run }.to change { shout.reactions.first.counter }.by(-1)
    end
  end

  context 'with a reaction turning zero' do
    let(:emoji) { '👻' }
    let(:emojis_from_cookie) { 'ghost' }

    before { shout.reactions.create!(emoji: emoji, counter: 1) }

    it 'removes a reaction' do
      expect { service.run }.to change { shout.reactions.count }.by(-1)
    end

    it 'removes from cookie' do
      expect(service.emojis_to_store).to eq ''
    end
  end
end
