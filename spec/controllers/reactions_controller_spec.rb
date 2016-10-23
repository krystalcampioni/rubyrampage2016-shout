require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  describe 'POST #create' do
    let!(:shout) { create(:shout) }

    before do
      post :create, reaction: { emoji: '👻' }, shout_id: shout.id
      post :create, reaction: { emoji: '👻' }, shout_id: shout.id
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(shout.reactions.count).to eq(1) }
    it { expect(response.body).to eq('[{"👻":2}]') }
  end
end
