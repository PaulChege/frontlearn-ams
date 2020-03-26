# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'creating course' do
  login_user

  before(:each) do
    @school = create(:school)
    visit new_school_course_path(@school)
  end

  scenario 'with valid attributes' do
    select 'Diploma', from: 'Level'
    fill_in 'Name', with: 'ICT'
    click_button 'Create Course'
    expect(page).to have_content('Diploma in ICT')
  end

  scenario 'with invalid attributes' do
    click_button 'Create Course'
    expect(page).to have_content("Name can't be blank")
  end
end
