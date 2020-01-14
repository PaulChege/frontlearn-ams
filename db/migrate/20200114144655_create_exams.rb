class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.string :semester_month
      t.string :semester_year
      t.integer :status
      t.timestamps
    end
  end
end
