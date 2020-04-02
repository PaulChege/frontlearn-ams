# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'assessments index page' do
  login_user

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    @assessment = create(:assessment)
    visit assessments_path
  end

  scenario 'opening index page' do
    expect(page).to have_content('Assessment Periods')
    expect(page.all('.table').count).to eq(1)
  end

  scenario 'creating new assessment with valid attributes' do
    find_field(id: 'assessment_semester_month').select('Apr')
    find_field(id: 'assessment_semester_year').select(Date.today.year)
    click_button('Create')
    expect(page).to have_content("Apr-#{Date.today.year}")
  end

  scenario 'creating new assessment with invalid attributes' do
    find_field(id: 'assessment_semester_month').select('Jan')
    find_field(id: 'assessment_semester_year').select(Date.today.year)
    click_button('Create')
    expect(page).to have_content('Assessment Period has already been created.')
  end

  scenario 'opening and closing assessment period' do
    find_link(href: "/assessments/#{@assessment.id}", text: 'Close').click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).to have_content('closed')
  end

  scenario 'deleting an assessment period' do
    find_link(href: "/assessments/#{@assessment.id}", text: 'Delete').click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(@assessment.full_semester_name)
  end
end
