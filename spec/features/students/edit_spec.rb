# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing a strudent' do
  login_user

  before(:each) do
    @student = create(:student)
    visit edit_student_path(@student)
  end

  scenario 'with valid attriutes' do
    fill_in('First name', with: 'New Name')
    click_button('Save')
    expect(page).to have_content('New Name')
  end

  scenario 'with invalid attributes' do
    fill_in('Email', with: '')
    click_button('Save')
    expect(page).to have_content("can't be blank")
  end
end
