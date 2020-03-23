# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses index page' do
  login_user

  before(:each) do
    @course = create(:course)
    Capybara.current_driver = :selenium_chrome
    visit school_courses_path(@course.school)
  end

  scenario 'rendering index page' do
    expect(page).to have_content("School of #{@course.school.name}")
  end

  scenario 'opening create course form' do
    click_link 'Create Course'
    expect(page).to have_content('Create Course')
    expect(page).to have_content('Level')
  end

  scenario 'opening edit course form' do
    find_link(href: "/schools/#{@course.school.id}/courses/#{@course.id}/edit").click
    expect(page).to have_content('Edit Course')
  end

  scenario 'opening course units page' do
    find_link(href: "/schools/#{@course.school.id}/courses/#{@course.id}/units").click
    expect(page).to have_content(@course.full_course_name)
  end

  scenario 'deleting course' do
    find_link(href: "/schools/#{@course.school.id}/courses/#{@course.id}").click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(@course.full_course_name)
  end
end
