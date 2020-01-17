# frozen_string_literal: true

# == Schema Information
#
# Table name: exams
#
#  id             :bigint           not null, primary key
#  semester_month :string
#  semester_year  :string
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Exam < ApplicationRecord
  has_many :results
  enum status: %i[open closed]

  def full_semester_name
    semester_month.to_s + '-' + semester_year.to_s
  end
end
