require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  describe 'POST #create' do
    let!(:shout) { create(:shout) }

    context 'response' do
      before do
        post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
        post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
        post :create, reaction: { emoji: '🤖' }, shout_id: shout.id, format: :js
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(shout.reactions.count).to eq(2) }
      it { expect(shout.reactions_array).to eq([{ emoji: '👻', counter: 2 }, { emoji: '🤖', counter: 1 }]) }
    end

    context 'using cookies to store reactions' do
      context 'with no cookie stored' do
        def create_action
          post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
        end

        it 'creates a new reaction' do
          expect { create_action }.to change { shout.reactions.count }.by(1)
        end

        it 'sets a cookie' do
          create_action
          expect(cookies["shout-#{shout.id}"]).to eq 'ghost'
        end

        it 'sets a cookie with more than one emoji' do
          post :create, reaction: { emoji: '👻' }, shout_id: shout.id, format: :js
          post :create, reaction: { emoji: '🤖' }, shout_id: shout.id, format: :js

          expect(cookies["shout-#{shout.id}"]).to eq 'ghost,robot'
        end
      end
    end
  end
end
