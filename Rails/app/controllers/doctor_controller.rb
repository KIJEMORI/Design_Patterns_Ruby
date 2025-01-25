class DoctorController < ApplicationController

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new question_params
    if @doctor.save
      redirect_to doctors_path
    else
      render :new
    end
  end

  private 
  def question_params
    params.require(:doctor).permit(:name, :profile, :date_of_birth)
  end

end