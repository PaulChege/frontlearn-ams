# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id          :bigint           not null, primary key
#  unit_id     :bigint
#  student_id  :bigint
#  exam_id     :bigint
#  attendance  :float
#  assignments :float
#  practicals  :float
#  cats        :float
#  final_exam  :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
