FactoryGirl.define do
  factory :shout do
    user
    shouter { create(:user) }
    message 'You rock!'
  end
end
