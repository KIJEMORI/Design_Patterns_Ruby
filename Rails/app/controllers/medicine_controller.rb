class MedicineController < ApplicationController

  def index
    @medicines = Medicine.all
  end

  def new
    @medicine = Medicine.new
  end

  def create
    render plain: params
  end

end 