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


require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
