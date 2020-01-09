# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  school_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  level      :integer
#

class Course < ApplicationRecord
  enum level: %w[Diploma Certificate]
  belongs_to :school
  has_many :students
  validates :name, presence: :true

  def full_course_name
    level + ' in ' + name
  end
end
