# frozen_string_literal: true

class UnitsController < ApplicationController
  before_action :get_unit, except: :index
  before_action :authorize

  def index
    @units = Unit.all.order(:code).page(params[:page])
  end

  def edit; end

  def update
    @unit.assign_attributes(unit_params)
    if @unit.save
      redirect_to units_path, notice: 'Unit updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @unit.destroy
    redirect_to units_path, notice: 'Unit deleted successfully.'
  end

  private

  def authorize
    authorize! :crud, Unit
  end

  def get_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:code, :name)
  end
end
