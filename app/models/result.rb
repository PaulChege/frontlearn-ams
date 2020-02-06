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

  scope :by_student, -> (assessment_id) {
      where(assessment_id: assessment_id)
      .where.not(final_grade: nil)
      .group_by(&:student_id)
    }

  def calculate_final_mark_and_grade
    if attendance && assignments && cats && practicals && final_exam
      pre_assessments = (attendance + assignments + practicals + cats) / 4
      self.final_mark = (pre_assessments + (final_exam * 0.7)).round(2)
      self.final_grade = calculate_final_grade(final_mark)
      self
    else
      self.final_mark = nil
      self
    end
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

  private

  def calculate_final_grade(mark)
    if mark < 40
      'F'
    elsif mark >= 40 && mark < 50
      'D'
    elsif mark >= 50 && mark < 60
      'C'
    elsif mark >= 60 && mark < 70
      'B'
    elsif mark >= 70
      'A'
    else
      ''
    end
  end
end
