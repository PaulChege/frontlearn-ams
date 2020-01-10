# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id            :bigint           not null, primary key
#  first_name    :string
#  last_name     :string
#  admission_no  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id     :bigint
#  email         :string
#  mobile_number :string
#  intake_month  :integer
#  intake_year   :integer
#

class Student < ApplicationRecord
  validates :first_name, :last_name, :email, :mobile_number, presence: :true
  belongs_to :course

  enum intake_month: %w[Jan Apr Jul Oct]

  def get_admission_no
    id.to_s.rjust(4, '0')
  end

  def self.get_intake_year_options
    current_year = Date.today.year
    [current_year - 1, current_year, current_year + 1]
  end

  def intake
    intake_month + '-' + intake_year.to_s
  end
end
