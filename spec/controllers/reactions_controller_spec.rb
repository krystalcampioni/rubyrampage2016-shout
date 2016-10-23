require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  describe 'POST #create' do
    let!(:shout) { create(:shout) }

    before do
      post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
      post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
      post :create, reaction: { emoji: '🤖' }, shout_id: shout.id, format: :js
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(shout.reactions.count).to eq(2) }
    it { expect(shout.reactions_array).to eq([{ emoji: '👻', counter: 2 }, { emoji: '🤖', counter: 1 }]) }
  end
end
