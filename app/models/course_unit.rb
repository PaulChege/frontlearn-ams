# frozen_string_literal: true

# == Schema Information
#
# Table name: course_units
#
#  id         :bigint           not null, primary key
#  course_id  :bigint
#  unit_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseUnit < ApplicationRecord
  belongs_to :course
  belongs_to :unit
end
