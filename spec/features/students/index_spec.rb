# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students index page' do
  login_user

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    course = create(:course)
    @students = create_list(:student, 5, course: course)
    visit students_path
  end

  scenario 'opening index page' do
    expect(page).to have_content('Students')
    expect(find('.table')).to have_content(@students.first.first_name)
  end

  scenario 'searching for student by name' do
    find_field(id: 'student_search_query')
      .fill_in(with: @students.first.first_name)
    find_button(name: 'button').click
    expect(page).to have_content(@students.first.first_name)
    expect(page.all('.table').count).to eq(1)
  end

  scenario 'searching for student by admission number' do
    find_field(id: 'student_search_query')
      .fill_in(with: @students.first.admission_no)
    find_button(name: 'button').click
    expect(page).to have_content(@students.first.admission_no)
    expect(page.all('.table').count).to eq(1)
  end

  scenario 'opening add student page' do
    click_link('Add Student')
    expect(page).to have_content('Add Student')
  end

  scenario 'opening edit student page' do
    find_link(href: "/students/#{@students.first.id}/edit").click
    expect(page).to have_content('Edit Student')
  end

  scenario 'deleting a student' do
    find_link(href: "/students/#{@students.first.id}").click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(@students.first.first_name)
  end
end
