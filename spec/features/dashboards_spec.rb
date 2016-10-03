require 'rails_helper'

RSpec.feature "Dashboard", type: :feature do
  before (:each) do
    sign_up
    visit dashboard_path
  end

  scenario 'user wants to shorten a url with vanity string' do
    create_a_link

    expect(page).to have_content 'Link was successfully created'
    expect(page).to have_content '1 Turbolink'
    expect(page).to have_content "localhost:3001/#{@slug}"
    visit "http://localhost:3001/#{@slug}"
    expect(page.driver.status_code).to eq 200
  end

  scenario 'user wants to view details of a link' do
    create_a_link

    click_link("localhost:3001/#{@slug}")
    expect(page).to have_content @url
    expect(page).to have_content "localhost:3001/#{@slug}"
    expect(page).to have_content 'Created'
    expect(page).to have_content 'Status:  Active'
  end

  scenario 'user wants to change the target of a shortened url' do
    create_a_link
    click_link("localhost:3001/#{@slug}")
    click_link('Edit')
    within '#edit-link' do
      fill_in 'link_given_url', with: 'http://materializecss.com'
      click_button 'Update Link'
    end
    expect(page.current_path).to eq '/users/dashboard'
    expect(page).to have_content 'Link has been updated'
    expect(page).to have_content @slug
    click_link "localhost:3001/#{@slug}"
    expect(page).to have_content 'http://materializecss'
  end

  scenario 'user deactivates a url' do
    create_a_link
    click_link("localhost:3001/#{@slug}")
    click_link 'Deactivate'
    expect(page).to have_content 'Link has been deactivated'
    expect(page).to have_content 'Status:  Deactivated'
    visit "http://localhost:3001/#{@slug}"
    expect(page).to have_content 'Sorry, this link has been deactivated.'
  end

  scenario 'user reactivates a previously deactivated link' do
    create_a_link
    click_link("localhost:3001/#{@slug}")
    click_link 'Deactivate'
    click_link 'Activate'
    expect(page).to have_content 'Link has been reactivated'
    expect(page).to have_content 'Status:  Active'
    visit "http://localhost:3001/#{@slug}"
    expect(page.driver.status_code).to eq 200
  end

  scenario 'user deletes a link' do
    create_a_link
    click_link("localhost:3001/#{@slug}")
    click_link 'Delete'
    expect(page).to have_content 'Link has been deleted'
    visit "http://localhost:3001/#{@slug}"
    expect(page).to have_content 'Sorry, this link either doesn\'t exist or has been deleted.'
  end

  def create_a_link
    @url = Faker::Internet.url
    @slug = Faker::Internet.slug
    fill_in 'link_given_url', with: @url
    fill_in 'link_slug', with: @slug
    click_button 'CREATE LINK'
  end
end
