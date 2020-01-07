# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id            :bigint           not null, primary key
#  first_name    :string
#  last_name     :string
#  admission_no  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id     :bigint
#  email         :string
#  mobile_number :string
#


class Student < ApplicationRecord
    validates :first_name, :last_name, :email, :mobile_number, presence: :true
    belongs_to :course

    def get_admission_no
			id.to_s.rjust(4, "0")
    end
end
