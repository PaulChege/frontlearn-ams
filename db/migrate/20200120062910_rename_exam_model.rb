# frozen_string_literal: true

class RenameExamModel < ActiveRecord::Migration[6.0]
  def change
    rename_table :exams, :assessments
    rename_column :results, :exam_id, :assessment_id
    add_column :results, :final_mark, :float
    add_column :results, :final_grade, :string
  end
end
