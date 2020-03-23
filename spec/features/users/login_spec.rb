# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Logging a user in', type: :feature do
  before(:each) do
    @user = create(:user)
    visit new_user_session_path
  end

  scenario 'with valid credentials' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content('Logged in successfully')
    expect(page).to have_content(@user.full_name)
  end

  scenario 'with invlalid credentials' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password')
  end
end
