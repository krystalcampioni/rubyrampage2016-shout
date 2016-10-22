FactoryGirl.define do
  factory :shout do
    user
    emoji_badge '\u{1f431}'
    shouter { create(:user) }
    message 'You rock!'
  end
end
