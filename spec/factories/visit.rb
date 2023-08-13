FactoryBot.define do
  factory :visit do
    link
    ip_address { Faker::Internet.ip_v4_address }
    browser_name { 'chrome' }
    os { 'mac' }
  end
end
