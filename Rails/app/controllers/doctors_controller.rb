class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new doctor_params
    if @doctor.save
      redirect_to doctors_path
    else
      render :new
    end
  end

  def edit
    @doctor = Doctor.find_by id: params[:id]
  end

  def update
    @doctor = Doctor.find_by id: params[:id]
    if @doctor.update doctor_params
      redirect_to doctors_path
    else
      render:edit
    end
  end

  private 
  def doctor_params
    params.require(:doctor).permit(:name, :profile, :date_of_birth)
  end

end