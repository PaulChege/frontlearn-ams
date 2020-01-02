# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  CreateCourses :string
#  school_id     :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


class Course < ApplicationRecord
end
