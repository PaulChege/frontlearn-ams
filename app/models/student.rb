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
  validates :mobile_number, phone: true
  belongs_to :course
  has_many :results, dependent: :delete_all

  scope :search_by_course_and_intake,
        lambda { |course_id, intake|
          select { |s| s.intake == intake && s.course_id == course_id }
        }

  scope :search_by_admission_or_name,
        lambda { |query|
          where('LOWER(first_name) LIKE ? ', "%#{query.downcase}%").or(
            where('LOWER(last_name) LIKE ? ', "%#{query.downcase}%")
          ).or(
            where('LOWER(admission_no) LIKE ? ', "%#{query.downcase}%")
          )
        }

  enum intake_month: %w[Jan Apr Jul Oct]

  self.per_page = 10

  def self.get_intake_year_options
    current_year = Date.today.year
    (current_year - 2...current_year + 1).to_a
  end

  def intake
    intake_month + '-' + intake_year.to_s
  end

  def self.intakes
    pluck(:intake_month, :intake_year).map { |a| a.join('-') }.uniq!
  end

  def full_name
    first_name + ' ' + last_name
  end
end
