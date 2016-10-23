require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:shout) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:emoji) }
  end
end
