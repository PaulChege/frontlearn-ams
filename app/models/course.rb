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
  belongs_to :school
  has_many :students, dependent: :nullify
  has_many :course_units, dependent: :delete_all
  has_many :units, through: :course_units, dependent: :delete_all

  validates :name, presence: :true

  enum level: %w[Diploma Certificate]

  def full_course_name
    level + ' in ' + name
  end
end
