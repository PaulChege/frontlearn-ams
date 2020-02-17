# frozen_string_literal: true

# == Schema Information
#
# Table name: assessments
#
#  id             :bigint           not null, primary key
#  semester_month :string
#  semester_year  :string
#  status         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Assessment < ApplicationRecord
  has_many :results
  enum status: %i[open closed]
  validate :semester_uniqueness

  def full_semester_name
    semester_month.to_s + '-' + semester_year.to_s
  end

  def semester_uniqueness
    self.class.all.each do |assessment|
      next if id == assessment.id

      if assessment.full_semester_name == full_semester_name
        errors.add(:base, 'Assessment Period has already been created.')
      end
    end
  end
end
