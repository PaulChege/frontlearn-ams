# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'creating a student' do
  login_user

  before(:each) do
    @course = create(:course)
    visit new_student_path
  end

  scenario 'with valid attributes' do
    fill_in('Admission no', with: 'FL001')
    fill_in('First name', with: 'Test')
    fill_in('Last name', with: 'Student')
    find_field(id: 'student_course_id').select(@course.full_course_name)
    find_field(id: 'student_intake_month').select('Jan')
    find_field(id: 'student_intake_year').select(Date.today.year)
    fill_in('Email', with: 'teststudent@gmail.com')
    fill_in('Mobile number', with: '0711222333')
    click_button('Add Student')
    expect(page).to have_content('Test')
  end

  scenario 'with invalid attributes' do
    click_button('Add Student')
    expect(page).to have_content("can't be blank")
  end
end
