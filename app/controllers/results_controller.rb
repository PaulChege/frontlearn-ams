# frozen_string_literal: true

class ResultsController < ApplicationController
  before_action :find_or_create_results, only: :edit_all
  def search
    @courses = Course.all
    @units = Unit.all
    @exams = Exam.where(status: 'open')
    @intakes = Student.intakes
  end

  def edit_all
    @course = Course.find(search_params[:course_id])
    @unit = Unit.find(search_params[:unit_id])
    @intake = search_params[:intake]
    @assessment = Exam.find(search_params[:exam_id])
    if @results.empty?
      redirect_to results_search_path, notice: 'No Results. There are no students scheduled for the chosen assessment.'
    end
  end

  def update
    Result.update(params[:results].keys, params[:results].values)
    redirect_to results_search_path, notice: 'Results updated successfully.'
  end

  private

  def search_params
    params.require(:search).permit(:course_id, :unit_id, :intake, :exam_id)
  end

  def find_or_create_results
    students = Student.where(
      course_id: search_params[:course_id]
    ).search_by_intake(search_params[:intake])

    @results = students.map do |student|
      student.results.find_or_create_by(
        unit_id: search_params[:unit_id],
        exam_id: search_params[:exam_id]
      )
    end
  end
end
