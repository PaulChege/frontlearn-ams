# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'course units index page' do
  login_user

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    @course = create(:course)
    @unit = create(:unit)
    @course_unit = create(:course_unit, course: @course, unit: create(:unit))
    visit school_course_units_path(@course.school, @course)
  end

  scenario 'opening manage all units page' do
    click_link('Manage All Units')
    expect(page).to have_content('Units for All Courses')
  end

  scenario 'creating a new unit' do
    fill_in('Code', with: 'ICT1')
    fill_in('Name', with: 'Introduction to Programming')
    click_button('Create')
    expect(page).to have_content('Unit created and added to course')
    expect(page).to have_content('Introduction to Programming')
  end

  scenario 'adding an existing unit' do
    find_field(id: 'unit_id').select(@unit.full_unit_name)
    click_button('Add')
    expect(page).to have_content('Unit added to course')
    expect(page).to have_content(@unit.full_unit_name)
  end

  scenario 'removing unit from course' do
    find_link(
      href: "/schools/#{@course.school.id}" \
      "/courses/#{@course.id}/units/#{@course_unit.unit.id}"
    ).click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page.find('.table')).not_to have_content(@course_unit.unit.code)
  end
end
