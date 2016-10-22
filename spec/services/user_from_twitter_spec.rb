require 'rails_helper'

RSpec.describe UserFromTwitter, :vcr do
  context 'an user which exists on twitter' do
    let(:service) { described_class.new('krystalcampioni') }

    describe '#attributes' do
      it 'returns the correct information' do
        expect(service.attributes).to eq(
          nickname: 'krystalcampioni',
          name: 'Krystal Campioni',
          profile_image_url: 'http://pbs.twimg.com/profile_images/779276930709393408/fVyN5kO8_normal.jpg'
        )
      end
    end
  end
  context 'an user which does not exist on twitter' do
    let(:service) { described_class.new('krystalcampionishkshkdhs') }

    describe '#attributes' do
      it 'raises twitter error' do
        expect { service.attributes }.to raise_error Twitter::Error::NotFound
      end
    end
  end
end
