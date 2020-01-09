# frozen_string_literal: true

class AddColumnsToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :name, :string
    add_column :courses, :level, :integer
    remove_column :courses, :CreateCourses, :string
  end
end
