require 'rails_helper'

RSpec.feature 'User logs in', type: :feature do
  let(:user) { create(:user) }
  before do
    visit dashboard_path
    click_link 'Sign In'
  end

  scenario 'user sees log in form' do
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_button 'Log in'
  end

  scenario 'with valid credentials' do
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Login Successful'
  end

  scenario 'with invalid credentials' do
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: 'incorrect'
    click_button 'Log in'

    expect(page).to have_content 'Invalid username/password combination'
  end
end
