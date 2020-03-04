# frozen_string_literal: true

class ChangeResultsAssessmentColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :results, :assessment, :final_assessment
  end
end
