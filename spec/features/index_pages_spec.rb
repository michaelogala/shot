require 'rails_helper'

RSpec.feature 'IndexPages', type: :feature, js: true do
  scenario 'user visits index page' do
    visit root_path
    expect(page).to have_content 'Recent Links'
    expect(page).to have_content 'Popular Links'
    expect(page).to have_content 'Influential Users'
  end

  describe 'shortening a link' do
    it 'creates a link with random slug' do
      visit root_path
      fill_in 'link_given_url', with: 'http://betterspecs.org/'
      click_button 'Shorten'
      expect(page.current_path).to eq '/'
      expect(page).to have_content 'Link was successfully created'
    end
  end

  scenario 'user attempts to sign up with valid details' do
    password = Faker::Internet.password(8)
    visit root_path
    click_link 'Sign Up'
    expect(page.current_path).to eq '/users/sign_up'
    fill_in 'user_first_name', with: Faker::Name.first_name
    fill_in 'user_last_name', with: Faker::Name.last_name
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
    expect(page.current_path).to eq '/users/dashboard'
    expect(page).to have_content 'You successfully signed up'
  end

  scenario 'user attempts to sign up with incomplete credentials' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_first_name', with: Faker::Name.first_name
    fill_in 'user_last_name', with: Faker::Name.last_name
    click_button 'Sign up'
    expect(page.current_path).to eq new_user_path
    expect(page).to have_content 'All fields are required'
  end

  scenario 'user attempts to log in with valid details' do
    sign_up
    visit sign_out_path
    visit root_path
    click_link 'Sign In'
    fill_in 'session_email', with: @email
    fill_in 'session_password', with: @password
    click_button 'Log in'
    expect(page).to have_content 'Login Successful'
    expect(page.current_path).to eq dashboard_path
  end

  scenario 'user attempts to log in with invalid credentials' do
    sign_up
    visit sign_out_path
    visit root_path
    click_link 'Sign In'
    fill_in 'session_email', with: 'nobody@anywhere.com'
    fill_in 'session_password', with: 'somepass'
    click_button 'Log in'
    expect(page.current_path).to eq log_in_path
    expect(page).to have_content 'Invalid username/password combination'
  end
end
