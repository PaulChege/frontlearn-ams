# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "schools' index page" do
  login_user

  before(:each) do
    @school = create(:school)
    Capybara.current_driver = :selenium_chrome
    visit schools_path
  end

  scenario 'rendering index page' do
    expect(page).to have_content('Schools')
    expect(page).to have_content(@school.name)
  end

  scenario 'opening create school form' do
    click_link('Create School')
    expect(page).to have_content('Create School')
  end

  scenario 'opening school courses page' do
    find_link(href: "/schools/#{@school.id}/courses").click
    expect(page).to have_content("School of #{@school.name}")
  end

  scenario 'deleting school' do
    find_link(href: "/schools/#{@school.id}").click
    expect(page).to have_content('Are you sure')
    click_button('Yes')
    expect(page).not_to have_content(@school.name)
  end
end
