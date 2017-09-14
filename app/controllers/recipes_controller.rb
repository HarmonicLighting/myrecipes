class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @chef = @recipe.chef
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def delete
  end
end
