# frozen_string_literal: true

FactoryBot.define do
  factory :school do
    name { Faker::Educator.subject }
  end
end
