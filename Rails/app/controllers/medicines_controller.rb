class MedicinesController < ApplicationController

  def index
    @medicines = Medicine.all
  end

  def new
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new medicine_params
    if @medicine.save
      redirect_to medicines_path
    else
      render :new
    end
  end

  def edit
    @medicine = Medicine.find_by id: params[:id]
  end

  def update
    @medicine = Medicine.find_by id: params[:id]
    if @medicine.update medicine_params
      redirect_to medicines_path
    else
      render:edit
    end
  end

  private 
  def medicine_params
    params.require(:medicine).permit(:name, :compound, :best_before_date)
  end
end 