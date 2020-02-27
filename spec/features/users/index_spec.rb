# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users index page', type: :feature do
  login_user

  let(:user) { create(:user) }

  scenario 'rendering index page' do
    user
    visit users_path
    expect(page).to have_content('Users')
    expect(page).to have_content(user.full_name)
  end

  scenario 'opening add user form' do
    visit users_path
    click_link('Add User')
    expect(page).to have_content('Add User')
  end

  scenario 'opening edit user form' do
    user
    visit users_path
    find_link(href: "/users/#{user.id}/edit").click
    expect(page).to have_content('Edit User')
  end

  scenario 'deleting user', js: true do
    Capybara.current_driver = :selenium_chrome
    user
    visit users_path
    find_link(href: "/users/#{user.id}").click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(user.full_name)
  end

  scenario 'logging out user' do
    visit users_path
    click_link('Logout')
    expect(page).to have_content('Log in')
  end
end
