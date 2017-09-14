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
  end

  def update
  end

  def delete
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name,:description)
  end
end
