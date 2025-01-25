class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new recipe_params
    if @recipe.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find_by id: params[:id]
  end

  def update
    @recipe = Recipe.find_by id: params[:id]
    if @recipe.update recipe_params
      redirect_to recipes_path
    else
      render:edit
    end
  end

  private 
  def recipe_params
    params.require(:recipe).permit(:medicine_id, :doctor_id, :name_of_patient)
  end
end