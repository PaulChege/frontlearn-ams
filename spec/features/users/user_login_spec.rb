require "rails_helper"

RSpec.describe 'Logging in a user', type: :feature do

  let(:user) {create(:user)}

  scenario "valid credentials" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button "Log in"
    expect(page).to have_content("successfully") 
    expect(page).to have_content(user.full_name) 
  end

  scenario "invlalid credentials" do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: "wrongpassword"
    click_button "Log in"
    expect(page).to have_content("Invalid") 
  end
end