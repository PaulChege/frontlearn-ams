# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :get_student, only: %i[edit update destroy]
  before_action :authorize, except: :index

  def index
    @students = Student.all.page(params[:page])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, notice: 'Student created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @student.assign_attributes(student_params)
    if @student.save
      redirect_to students_path, notice: 'Student updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: 'Student deleted successfully'
  end

  private

  def student_params
    params.require(:student).permit(
      :admission_no,
      :first_name,
      :last_name,
      :course_id,
      :intake_month,
      :intake_year,
      :email,
      :mobile_number
    )
    end

  private

  def authorize
    authorize! :modify, Student
  end

  def get_student
    @student = Student.find(params[:id])
  end
end
