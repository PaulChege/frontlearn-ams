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

require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
