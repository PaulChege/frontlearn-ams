# frozen_string_literal: true

class CreateCourseUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :course_units do |t|
      t.references :course, foreign_key: true
      t.references :unit, foreign_key: true
      t.timestamps
    end
  end
end
