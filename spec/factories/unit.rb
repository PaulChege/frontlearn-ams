# frozen_string_literal: true

FactoryBot.define do
  factory :unit do
    code { Faker::Code.asin }
    name { Faker::Educator.course_name }
  end
end
