class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page],per_page:5)
  end

  def show
    @comment = @recipe.comments.build()
    @comments = @recipe.comments.paginate(page: params[:page],per_page:5)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
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
    if @recipe.update(recipe_params)
      flash[:success]= ["Edited!", "Recipe was edited successfully!"]
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      flash[:info]= ["Confirmation", "The recipe was deleted"]
      redirect_to recipes_path
    else
      flash[:warning]= ["Something went wring.", "We were unable to delete the post at this time."]
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name,:description, :difficulty_level_id, ingredient_ids:[])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_chef != @recipe.chef && !current_chef.admin?
      flash[:danger] = ["Invalid","You can only edit or delete your own recipes"]
      redirect_to recipes_path
    end
  end
end
