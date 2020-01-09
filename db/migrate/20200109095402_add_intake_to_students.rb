# frozen_string_literal: true

class AddIntakeToStudents < ActiveRecord::Migration[6.0]
  def up
    add_column :students, :intake_month, :integer
    add_column :students, :intake_year, :integer
  end
end
