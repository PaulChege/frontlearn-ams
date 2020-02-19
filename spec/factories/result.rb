# frozen_string_literal: true

FactoryBot.define do
  factory :result do
    unit
    student
    assessment
    attendance  { 30 }
    assignments { 30 }
    practicals  { 30 }
    cats { 30 }
    final_exam   { 100 }
    final_mark   { 100 }
    final_grade  { 'A' }
  end
end
