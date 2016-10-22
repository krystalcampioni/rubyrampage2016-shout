require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:shouts) }
    it { is_expected.to have_many(:sent_shouts).class_name('Shout').with_foreign_key(:shouter_id) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_uniqueness_of(:nickname) }
    it { is_expected.to validate_presence_of(:profile_image_url) }
  end
end
