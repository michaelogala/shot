require 'rails_helper'
require 'support/users_helper'

RSpec.feature 'User manages link', type: :feature do
  let(:link) { build(:link) }

  before do
    sign_up
    create_a_link(link)
    visit dashboard_path
  end

  scenario 'when user views details of a link' do
    click_link("/#{link.slug}")

    expect(page).to have_content link.given_url
    expect(page).to have_content link.slug.to_s
    expect(page).to have_content 'Status:  Active'
  end

  scenario 'when user changes target of a shortened url' do
    click_link("/#{link.slug}")
    click_link('Edit')

    within '#edit-link' do
      fill_in 'link_given_url', with: 'materializecss.com'
      click_button 'Update Link'
    end

    expect(page).to have_content 'Link has been updated'
    click_link "/#{link.slug}"
    expect(page).to have_content 'materializecss'
  end

  scenario 'when user changes slug of shortened url' do
    click_link("/#{link.slug}")
    click_link('Edit')

    within '#edit-link' do
      fill_in 'link_slug', with: 'modified'
      click_button 'Update Link'
    end

    expect(page).to have_content 'Link has been updated'
    click_link '/modified'
    expect(page).to have_content ENV['BASE_URL'] + 'modified'
  end

  scenario 'when user deactivates a link' do
    click_link("/#{link.slug}")
    click_link 'Deactivate'
    expect(page).to have_content 'Link has been deactivated'
    expect(page).to have_content 'Status:  Disabled'
  end

  scenario 'when user reactivates a link' do
    click_link("/#{link.slug}")
    click_link 'Deactivate'
    click_link 'Activate'
    expect(page).to have_content 'Link has been reactivated'
    expect(page).to have_content 'Status:  Active'
  end

  scenario 'when user deletes a link' do
    click_link("/#{link.slug}")
    click_link 'Delete'
    expect(page).to have_content 'Link has been deleted'
  end
end
