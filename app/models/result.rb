# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id              :bigint           not null, primary key
#  unit_id         :bigint
#  student_id      :bigint
#  assessment_id   :bigint
#  attendance      :float
#  assignments     :float
#  cat_practical   :float
#  cat_theory      :float
#  final_practical :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  final_theory    :float
#  assessment      :integer
#

class Result < ApplicationRecord
  belongs_to :assessment
  belongs_to :student
  belongs_to :unit

  before_update :calculate_final_assessment

  scope :by_student, lambda { |assessment_id|
                       where(assessment_id: assessment_id)
                         .where.not(final_assessment: nil)
                         .group_by(&:student_id)
                     }

  enum final_assessment: %i[competent not_competent]

  self.per_page = 10

  def calculate_final_assessment
    unless complete?
      self.final_assessment = nil
      return self
    end
    self.final_assessment = is_competent? ? :competent : :not_competent
    self
  end

  def self.send_email_notifications(assessment_id, results_by_student)
    assessment = Assessment.find(assessment_id)
    results_by_student.each do |student_id, results|
      student = Student.find(student_id)
      ResultsMailer.with(student: student, results: results, assessment: assessment)
                   .results_email
                   .deliver_later
    end
  end

  def self.find_or_create_by_unit(search_params)
    students = Student.search_by_course_and_intake(
      search_params[:course_id].to_i,
      search_params[:intake]
    )

    results = students.map do |student|
      student.results.find_or_create_by(
        unit_id: search_params[:unit_id]
      )
    end

    return results if results.empty?

    validate_assessment(
      results.first.assessment_id,
      search_params[:assessment_id].to_i,
      results
    )
  end

  private

  def self.validate_assessment(results_assessment, selected_assessment, results)
    if (results_assessment != selected_assessment) && !results_assessment.nil?
      results.each { |r| r.destroy if r.assessment_id.nil? }
      results = []
    end

    results.each do |result|
      if result.assessment_id.nil?
        result.update(assessment_id: selected_assessment)
      end
    end

    results
  end

  def is_competent?
    attendance >= 80 &&
      assignments >= 50 &&
      cat_practical >= 80 &&
      cat_theory >= 50 &&
      final_practical >= 80 &&
      final_theory >= 50
  end

  def complete?
    attendance &&
      assignments &&
      cat_practical &&
      cat_theory &&
      final_practical &&
      final_theory
  end
end
