# frozen_string_literal: true

class ExamsController < ApplicationController
  before_action :find_exam, only: %i[change_status destroy update]
  def index
    @exams = Exam.all
    @exam = Exam.new
  end

  def change_status; end

  def create
    @exam = Exam.new(exam_params)
    @exam.status = 'open'
    if @exam.save
      redirect_to exams_path, notice: 'Exam period created successfully.'
    else
      render :index
    end
  end

  def update
    @exam.open? ? @exam.closed! : @exam.open!
    redirect_to exams_path, notice: 'Exam period updated successfully.'
  end

  def destroy
    @exam.delete
    redirect_to exams_path, notice: 'Exam period removed successfully.'
  end

  private

  def exam_params
    params.require(:exam).permit(:semester_month, :semester_year, :status)
  end

  def find_exam
    @exam = Exam.find(params[:id])
  end
end
