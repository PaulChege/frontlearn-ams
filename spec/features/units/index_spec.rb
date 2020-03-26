# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'all units index page' do
  login_user

  before(:each) do
    @unit =  create(:unit)
    Capybara.current_driver = :selenium_chrome
    visit units_path
  end

  scenario 'rendering index page' do
    expect(page).to have_content('Units for All Courses')
  end

  scenario 'opening edit page' do
    find_link(href: "/units/#{@unit.id}/edit").click
    expect(page).to have_content('Edit Unit')
  end

  scenario 'deleting unit' do
    find_link(href: "/units/#{@unit.id}").click
    click_button('Yes')
    expect(page).not_to have_content(@unit.full_unit_name)
  end
end
