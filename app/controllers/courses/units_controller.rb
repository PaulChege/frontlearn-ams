# frozen_string_literal: true

class Courses::UnitsController < ApplicationController
  before_action :get_school, :get_course, :get_units,
                :authorize, except: :units_json
  before_action :get_all_units, except: %i[units_json destroy]

  def index
    @unit = Unit.new
  end

  def units_json
    @units = Course.find(params[:id]).units
    respond_to do |format|
      format.json { render json: @units }
    end
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      @course.units << @unit
      redirect_to school_course_units_path(@school, @course),
                  notice: 'Unit created and added to course successfully.'
    else
      render :index
    end
  end

  def add_unit
    @unit = Unit.find(params[:unit][:id])
    if !@course.units.exists?(@unit.id)
      @course.units << @unit
      redirect_to school_course_units_path(@school, @course),
                  notice: 'Unit added to course successfully.'
    else
      @unit.errors.add(:base, 'Unit already added.')
      render :index
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @course.units.delete(@unit)
    redirect_to school_course_units_path(@school, @course),
                notice: 'Unit removed successfully.'
  end

  private

  def authorize
    authorize! :crud, Unit
  end

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
    @units = @course.units.order(:code).page(params[:page])
  end

  def get_all_units
    @all_units = Unit.all.order(:code)
  end
end
