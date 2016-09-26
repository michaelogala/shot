FactoryGirl.define do
  factory :visit do
    link_id 1
    ip_address  '127.0.0.1'
    browser_name 'chrome'
    os 'mac'
  end
end