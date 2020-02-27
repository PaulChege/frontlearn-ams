# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users index page', type: :feature do
  login_user

  before(:each) do
    @user = create(:user)
    Capybara.current_driver = :selenium_chrome
    visit users_path
  end

  scenario 'rendering index page' do
    expect(page).to have_content('Users')
    expect(page).to have_content(@user.full_name)
  end

  scenario 'opening add user form' do
    click_link('Add User')
    expect(page).to have_content('Add User')
  end

  scenario 'opening edit user form' do
    find_link(href: "/users/#{@user.id}/edit").click
    expect(page).to have_content('Edit User')
  end

  scenario 'deleting user', js: true do
    find_link(href: "/users/#{@user.id}").click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(@user.full_name)
  end

  scenario 'logging out user' do
    click_link('Logout')
    expect(page).to have_content('Log in')
  end
end
