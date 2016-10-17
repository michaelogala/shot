require 'rails_helper'

RSpec.feature 'User logs out', type: :feature do
  scenario 'when user clicks the sign out link' do
    sign_in

    find_link('Sign Out').click
    expect(page).to have_content 'You have logged out'
  end
end
