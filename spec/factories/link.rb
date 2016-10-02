FactoryGirl.define do
  factory :link do
    given_url Faker::Internet.url
    slug Faker::Internet.slug
  end
end
