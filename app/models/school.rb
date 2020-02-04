# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class School < ApplicationRecord
  has_many :courses, dependent: :destroy
end
