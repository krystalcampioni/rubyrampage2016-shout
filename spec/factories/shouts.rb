FactoryGirl.define do
  factory :shout do
    user
    shouter { create(:user) }
  end
end
