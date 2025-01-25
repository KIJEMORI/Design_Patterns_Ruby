class RecipeController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new question_params
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  private 
  def question_params
    params.require(:recipe).permit(:medicine_id, :doctor_id, :name_of_patient)
  end
end