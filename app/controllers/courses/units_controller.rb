# frozen_string_literal: true

class Courses::UnitsController < ApplicationController
  before_action :get_school, :get_course, :get_units
  def index
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      @course.units << @unit
      redirect_to school_course_units_path(@school, @course), notice: 'Unit created and added to course successfully.'
    else
      render :index
    end
  end

  def add_unit
    @unit = Unit.find(params[:unit][:id])
    if !@course.units.exists?(@unit.id)
      @course.units << @unit
      redirect_to school_course_units_path(@school, @course), notice: 'Unit added to course successfully.'
    else
      @unit.errors.add(:base, 'Unit already added.')
      render :index
    end
  end

  def destroy; end

  private

  def unit_params
    params.require(:unit).permit(:code, :name)
  end

  def get_school
    @school = School.find(params[:school_id])
  end

  def get_course
    @course = @school.courses.find(params[:course_id])
  end

  def get_units
    @units = @course.units
  end
end
