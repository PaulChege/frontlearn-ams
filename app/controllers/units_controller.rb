# frozen_string_literal: true

class UnitsController < ApplicationController
  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to schools_path, notice: 'Unit created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def unit_params
    params.require(:unit).permit(:code, :name)
  end
end
