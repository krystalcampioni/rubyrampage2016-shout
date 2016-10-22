FactoryGirl.define do
  factory :user do
    name 'Nome'
    nickname "nickname_#{SecureRandom.hex(2)}"
    profile_image_url "http://placehold.it/200/200"
  end
end
