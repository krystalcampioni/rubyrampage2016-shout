require 'rails_helper'

RSpec.describe ShoutUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:shout) }
  end
end
