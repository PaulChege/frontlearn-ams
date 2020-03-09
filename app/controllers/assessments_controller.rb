# frozen_string_literal: true

class AssessmentsController < ApplicationController
  before_action :find_assessment, only: %i[change_status destroy update]
  before_action :authorize

  def index
    @assessments = Assessment.all
                             .order(semester_year: :desc)
                             .page(params[:page])
    @assessment = Assessment.new
  end

  def create
    @assessment = Assessment.new(assessment_params)
    @assessment.status = 'open'
    if @assessment.save
      redirect_to assessments_path, notice: 'Assessment period created successfully.'
    else
      @assessments = Assessment.all
      render :index
    end
  end

  def update
    @assessment.open? ? @assessment.closed! : @assessment.open!
    redirect_to assessments_path, notice: 'Assessment period updated successfully.'
  end

  def destroy
    @assessment.destroy
    redirect_to assessments_path, notice: 'Assessment period removed successfully.'
  end

  private

  def assessment_params
    params.require(:assessment).permit(:semester_month, :semester_year, :status)
  end

  def find_assessment
    @assessment = Assessment.find(params[:id])
  end

  def authorize
    authorize! :crud, Assessment
  end
end
