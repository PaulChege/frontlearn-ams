# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students index page' do
  login_user

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    @students = create_list(:student, 5)
    visit students_path
  end

  scenario 'opening index page' do
    expect(page).to have_content('Students')
    expect(find('.table')).to have_content(@students.first.first_name)
  end
end
