FactoryGirl.define do
  factory :user do
    name 'Nome'
    sequence(:nickname) { |n| "nickname_#{n}" }
    profile_image_url 'http://placehold.it/200/200'
  end
end
