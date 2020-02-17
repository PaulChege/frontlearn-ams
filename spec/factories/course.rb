# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    school
    name { Faker::Educator.degree }
    level { 'Diploma' }
  end
end
