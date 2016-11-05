FactoryGirl.define do
  factory :visit do
    link_id 1
    ip_address { Faker::Internet.ip_v4_address }
    browser_name 'chrome'
    os 'mac'
  end
end
