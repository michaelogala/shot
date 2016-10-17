require 'rails_helper'
require 'support/users_helper'

RSpec.feature "User creates a shortened url", type: :feature do

  scenario 'when user is anonymous' do
    visit root_path

    fill_in 'link_given_url', with: Faker::Internet.url
    click_button 'Shorten'

    expect(page.current_path).to eq root_path
    expect(page).to have_content 'Link was successfully created'
  end

  scenario 'when user is signed in and does not provide a slug' do
    url = Faker::Internet.url
    sign_up
    visit dashboard_path

    fill_in 'link_given_url', with: url
    click_button 'CREATE LINK'

    expect(page).to have_content 'Link was successfully created'
  end

  scenario 'when user is signed in and provides a slug' do
    url = Faker::Internet.url
    slug = Faker::Internet.slug

    sign_up
    visit dashboard_path

    fill_in 'link_given_url', with: url
    fill_in 'link_slug', with: slug
    click_button 'CREATE LINK'

    expect(page).to have_content 'Link was successfully created'
    expect(page).to have_content slug
  end
end
