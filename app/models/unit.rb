# frozen_string_literal: true

# == Schema Information
#
# Table name: units
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ApplicationRecord
  has_many :course_units
  has_many :courses, through: :course_units
  validates :code, :name, presence: true, uniqueness: true

  def full_unit_name
    code + '-' + name
  end
end
