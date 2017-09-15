class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @chef = @recipe.chef
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first # temporary
    if @recipe.save
      flash[:success]= ["Created!", "Recipe was created successfully!"]
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success]= ["Edited!", "Recipe was edited successfully!"]
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:info]= ["Confirmation", "The recipe was deleted"]
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name,:description)
  end
end
