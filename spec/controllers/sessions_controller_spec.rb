require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET create' do
    let(:twitter_hash) do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '12354567',
        info: {
          nickname: 'johnfuu',
          name: 'John Lord',
          image: 'https://example.com/image'
        }
      )
    end

    before do
      request.env['omniauth.auth'] = twitter_hash
      get :create, params: { provider: 'twitter' }
    end

    it { expect(session[:user_id]).to_not be_nil }
    it { expect(response).to redirect_to(root_path) }
    it { expect(assigns(:user)).to eq(User.find_by(nickname: 'johnfuu')) }
  end

  describe 'GET logout' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
      get :logout
    end

    it { expect(session[:user_id]).to be_nil }
    it { expect(response).to redirect_to(root_path) }
  end
end
