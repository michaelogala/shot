require 'rails_helper'

RSpec.feature "User signs up", type: :feature do
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(8) }

  before :each do
    visit root_path
    click_link 'Sign Up'
  end

  scenario 'with valid credentials' do

    fill_in 'user_first_name', with: first_name
    fill_in 'user_last_name', with: last_name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'

    expect(page.current_path).to eq dashboard_path
    expect(page).to have_link 'Sign Out'
    expect(page).to have_content 'You successfully signed up'
  end

  scenario 'without supplying any details' do
    click_button 'Sign up'
    expect(page.current_path).to eq new_user_path
    expect(page).to have_content 'All fields are required'
  end

  scenario 'without providing password confirmation' do
    fill_in 'user_first_name', with: first_name
    fill_in 'user_last_name', with: last_name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password

    click_button 'Sign up'

    expect(page.current_path).to eq new_user_path
    expect(page).to have_content 'All fields are required'
  end
end
