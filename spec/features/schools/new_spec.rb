require 'rails_helper'

RSpec.describe 'creating a school' do
  login_user

  before(:each) do
    visit new_school_path
  end

  scenario 'with valid attributes' do
    fill_in('Name', with: 'ICT')
    click_button('Create School') 
    expect(page).to have_content('ICT') 
  end

  scenario 'with invalid attributes' do
    click_button('Create School')
    expect(page).to have_content("Name can't be blank")
  end
end