# frozen_string_literal: true

class ResultsController < ApplicationController
  before_action :find_or_create_results, only: :edit_all

  def index
    @assessments = Assessment.all
    @courses = Course.all
    @results = []
    if params[:search].present?
      @results = Result
                 .where(unit_id: search_params[:unit_id])
                 .where(assessment_id: search_params[:assessment_id])
      @params = search_params
    end
  end

  def search
    @courses = Course.all
    @units = Unit.all
    @assessments = Assessment.where(status: 'open')
    @intakes = Student.intakes
    if @assessments.empty?
      redirect_to root_path, notice: 'Sorry, There are currently no open assessments.'
    end
  end

  def edit_all
    if @results.empty? || !search_params[:course_id].present?
      redirect_to results_search_path,
                  notice: 'No Results. There are no students scheduled for the chosen assessment.'
      return
    end
    @course = Course.find(search_params[:course_id])
    @unit = Unit.find(search_params[:unit_id])
    @intake = search_params[:intake]
    @assessment = Assessment.find(search_params[:assessment_id])
    @redirect_params = { 'search' => search_params }
  end

  def update
    Result.update(params[:results].keys, params[:results].values)
    redirect_to results_edit_all_path('search' => search_params),
                notice: 'Results updated successfully.'
  end

  private

  def search_params
    params.require(:search).permit(:course_id, :unit_id, :intake, :assessment_id)
  end

  def find_or_create_results
    students = Student.where(
      course_id: search_params[:course_id]
    ).search_by_intake(search_params[:intake])

    @results = students.map do |student|
      student.results.find_or_create_by(
        unit_id: search_params[:unit_id],
        assessment_id: search_params[:assessment_id]
      )
    end
  end
end
