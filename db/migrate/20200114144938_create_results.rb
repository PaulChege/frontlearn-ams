class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :unit, foreign_key: true
      t.references :student, foreign_key: true
      t.references :exam, foreign_key: true
      t.float :attendance
      t.float :assignments
      t.float :practicals
      t.float :cats
      t.float :final_exam
      t.timestamps
    end
  end
end
