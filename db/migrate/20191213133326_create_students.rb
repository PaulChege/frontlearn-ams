# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :admission_no
      t.timestamps
    end
  end
end
