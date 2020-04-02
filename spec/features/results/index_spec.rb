# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'results view page' do
  login_user

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    Capybara.default_max_wait_time = 3
    @course_unit = create(:course_unit)
    @assessment = create(:assessment)
    @result = create(:result, unit: @course_unit.unit, assessment: @assessment)
    visit results_path
  end

  scenario 'opening view page' do
    expect(page).to have_content('View Assessment Results')
  end

  scenario 'searching for results' do
    find_field(id: 'search_course_id').select(@course_unit.course.full_course_name)
    find_field(id: 'search_unit_id').select(@course_unit.unit.name)
    find_field(id: 'search_assessment_id').select(@assessment.full_semester_name)
    click_button('Search')
    expect(page.all('.table').count).to eq(1)
    expect(page).to have_content(@result.attendance)
  end
end
