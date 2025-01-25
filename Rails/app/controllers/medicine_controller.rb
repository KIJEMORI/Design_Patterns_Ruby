class MedicineController < ApplicationController

  def index
    @medicines = Medicine.all
  end

  def new
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new question_params
    if @medicine.save
      redirect_to medicines_path
    else
      render :new
    end
  end

  private 
  def question_params
    params.require(:medicine).permit(:name, :compound, :best_before_date)
  end
end 