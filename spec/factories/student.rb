# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admission_no { Faker::Number.number(digits: 4) }
    email { Faker::Internet.email }
    mobile_number { Faker::PhoneNumber.cell_phone }
    intake_month { 1 }
    intake_year { Time.now.year }
    course
  end
end
