FactoryGirl.define do
  factory :shout do
    shouter { create(:user) }
    message 'You rock!'
  end
end
