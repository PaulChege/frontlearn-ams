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

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
