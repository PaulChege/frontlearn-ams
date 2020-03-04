# frozen_string_literal: true

class ChangeResultsColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :results, :practicals, :cat_practical
    rename_column :results, :cats, :cat_theory
    rename_column :results, :final_exam, :final_practical
    rename_column :results, :final_mark, :final_theory
    remove_column :results, :final_grade
    add_column :results, :assessment, :integer
  end
end
