# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :get_school, :authorize
  before_action :get_course, only: %i[edit update destroy]

  def index
    @courses = Course.where(school_id: @school.id)
  end

  def new
    @course = Course.new
  end

  def create
    @course = @school.courses.new(course_params)
    if @course.save
      redirect_to school_courses_path, notice: 'Course created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @course.assign_attributes(course_params)
    if @course.save!
      redirect_to school_courses_path, notice: 'Course updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @course.delete
    redirect_to school_courses_path, notice: 'Course deleted successfully.'
  end

  private

  def authorize
    authorize! :crud, Course
  end

  def get_school
    @school = School.find(params[:school_id])
  end

  def get_course
    @course = @school.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:level, :name)
  end
end
