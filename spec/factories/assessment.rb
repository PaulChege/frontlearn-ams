# frozen_string_literal: true

FactoryBot.define do
  factory :assessment do
    semester_month { 'Jan' }
    semester_year { Time.now.year }
    status { :open }
  end
end
