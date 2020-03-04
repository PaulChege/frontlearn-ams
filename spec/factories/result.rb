# frozen_string_literal: true

FactoryBot.define do
  factory :result do
    unit
    student
    assessment
    attendance  { 80 }
    assignments { 80 }
    cat_practical { 80 }
    cat_theory { 30 }
    final_practical { 100 }
    final_theory { 80 }
    final_assessment { :competent }
  end
end
