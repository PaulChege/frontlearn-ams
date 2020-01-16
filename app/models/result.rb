# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id          :bigint           not null, primary key
#  unit_id     :bigint
#  student_id  :bigint
#  exam_id     :bigint
#  attendance  :float
#  assignments :float
#  practicals  :float
#  cats        :float
#  final_exam  :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :student
  belongs_to :unit
end
