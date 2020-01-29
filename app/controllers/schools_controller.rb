# frozen_string_literal: true

class SchoolsController < ApplicationController
  before_action :authorize

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to schools_path, notice: 'School created successfully.'
    else
      render :new
    end
  end

  def destroy
    School.find(params[:id]).delete
    redirect_to schools_path, notice: 'School deleted successfully.'
  end

  private

  def authorize
    authorize! :crud, School  
  end

  def school_params
    params.require(:school).permit(:name)
  end
end
