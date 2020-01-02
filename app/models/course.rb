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


class Course < ApplicationRecord
    enum level: %w(Diploma Certificate)
    belongs_to :school
    validates :name, presence: :true
end
