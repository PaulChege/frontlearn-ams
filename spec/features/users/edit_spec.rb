# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "editting a user's details" do
  login_user

  let(:user) { create(:user) }

  scenario 'with valid attributes' do
    visit edit_user_path(user)
    fill_in 'Full name', with: 'Test User'
    click_button('Save')
    expect(page).to have_content('User updated successfully')
  end

  scenario 'with invalid attributes' do
    visit edit_user_path(user)
    fill_in 'Full name', with: ''
    click_button('Save')
    expect(page).to have_content("Full name can't be blank")
  end
end
