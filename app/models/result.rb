# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id            :bigint           not null, primary key
#  unit_id       :bigint
#  student_id    :bigint
#  assessment_id :bigint
#  attendance    :float
#  assignments   :float
#  practicals    :float
#  cats          :float
#  final_exam    :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  final_mark    :float
#  final_grade   :string
#

class Result < ApplicationRecord
  belongs_to :assessment
  belongs_to :student
  belongs_to :unit

  before_update :calculate_final_mark_and_grade

  scope :by_student, lambda { |assessment_id|
                       where(assessment_id: assessment_id)
                         .where.not(final_grade: nil)
                         .group_by(&:student_id)
                     }

  def calculate_final_mark_and_grade
    if attendance && assignments && cats && practicals && final_exam
      pre_assessments = (attendance + assignments + practicals + cats) / 4
      self.final_mark = (pre_assessments + (final_exam * 0.7)).round(2)
      self.final_grade = calculate_final_grade(final_mark)
    else
      self.final_mark = nil
    end
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
    if results_assessment.nil?
      results.each do |result|
        result.update(assessment_id: selected_assessment)
      end
    elsif results_assessment != selected_assessment
      results = []
    end
    results
  end

  def calculate_final_grade(mark)
    case mark
    when 0..39.99
      'F'
    when 40..49.99
      'D'
    when 50..59.99
      'C'
    when 60..69.99
      'B'
    when 70..100
      'A'
    else
      ''
    end
  end
end
