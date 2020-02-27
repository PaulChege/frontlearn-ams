# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'creating a user', type: :feature do
  login_user

  before(:each) do
    visit new_user_path
  end

  scenario 'with valid attributes' do
    full_name = 'Test User'
    fill_in 'Full name', with: full_name
    fill_in 'Email', with: 'test@email.com'
    choose('Lecturer')
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button('Add User')
    expect(page).to have_content(full_name)
  end

  scenario 'with invalid attributes' do
    full_name = 'Test User'
    fill_in 'Full name', with: full_name
    fill_in 'Email', with: 'test@email.com'
    choose('Lecturer')
    click_button('Add User')
    expect(page).to have_content("Password can't be blank")
  end
end
