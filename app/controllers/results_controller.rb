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
                 .order(:final_assessment, final_theory: :desc)
                 .page(params[:page])
      @params = search_params
    end
  end

  def search
    @courses = Course.all
    @units = Unit.all
    @assessments = Assessment.where(status: 'open')
    @intakes = Student.intakes
    if @assessments.empty?
      redirect_to root_path, notice:
        'Sorry, There are currently no open assessments.'
    end
  end

  def edit_all
    if @results.empty? || !search_params[:course_id].present?
      redirect_to results_search_path,
                  notice: 'No Results.
                    There are no students scheduled for the chosen assessment.'
      return
    end
    @course = Course.find(search_params[:course_id])
    @unit = Unit.find(search_params[:unit_id])
    @intake = search_params[:intake]
    @assessment = Assessment.find(search_params[:assessment_id])
    @redirect_params = { 'search' => search_params }
  end

  def update_all
    Result.update(params[:results].keys, params[:results].values)
    redirect_to results_edit_all_path('search' => search_params),
                notice: 'Results updated successfully.'
  end

  def choose_period
    @assessments = Assessment.where(status: 'open')
  end

  def send_notifications
    results_by_student = Result.by_student(send_params[:assessment_id])
    if results_by_student.empty?
      redirect_to results_choose_period_path,
                  notice: 'No Results.
                    There are no final results for the period selected.'
    else
      Result.send_email_notifications(send_params[:assessment_id], results_by_student)
      redirect_to results_choose_period_path,
                  notice: 'Results successfully sent!'
    end
  end

  private

  def search_params
    params.require(:search).permit(:course_id, :unit_id, :intake, :assessment_id)
  end

  def send_params
    params.require(:send).permit(:assessment_id)
  end

  def find_or_create_results
    @results = Result.find_or_create_by_unit(search_params)
  end
end
