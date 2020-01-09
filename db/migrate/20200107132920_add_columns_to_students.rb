# frozen_string_literal: true

class AddColumnsToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :course, foreign_key: :true
    add_column :students, :email, :string
    add_column :students, :mobile_number, :string
    change_column :students, :admission_no, :string
  end
end
