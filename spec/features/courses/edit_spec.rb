require 'rails_helper'

RSpec.describe 'editing a course' do
  login_user

  before(:each) do
    @course = create(:course)
    visit(edit_school_course_path(@course.school, @course))
  end

  scenario 'with valid attributes' do
    fill_in('Name', with: 'Computer Science')
    click_button('Save')
    expect(page).to have_content('Computer Science')
  end

  scenario 'with invalid attributes' do
    fill_in('Name', with: '')
    click_button('Save')
    expect(page).to have_content("Name can't be blank")
  end
end