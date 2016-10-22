require 'rails_helper'

RSpec.describe ShoutsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:shout) { create(:shout, user: user) }
  let!(:other_shout) { create(:shout) }
  let!(:sent_shout) { create(:shout, shouter: user) }

  describe 'GET #index' do
    it 'shows the shouts of a given user' do
      get :index, params: { user_id: user.nickname }
      expect(assigns(:shouts)).to contain_exactly(shout)
    end

    it 'renders 404 if user not found' do
      expect do
        get :index, params: { user_id: 'batman' }
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'GET #me' do
    context 'with a logged user' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'shows its shouts' do
        get :me
        expect(assigns(:shouts)).to contain_exactly(shout)
        expect(assigns(:sent_shouts)).to contain_exactly(sent_shout)
        expect(assigns(:shout)).to be_an_instance_of(Shout)
      end
    end

    context 'without a logged user' do
      before do
        allow(controller).to receive(:current_user).and_return(nil)
      end

      it 'redirects to root_path' do
        get :me
        is_expected.to redirect_to root_path
      end
    end
  end
end
