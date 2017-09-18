class IngredientsController < ApplicationController

  before_action :set_ingredient, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:show, :index]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success]= ["Added!", "Ingredient #{@ingredient.name} was added successfully!"]
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success]= ["Edited!", "Ingredient #{@ingredient.name} was edited successfully!"]
      redirect_to ingredient_path(@ingredient)
    else
      render 'edit'
    end
  end

  def show
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page:5)
  end

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    if @ingredient.destroy
      flash[:info]= ["Confirmation", "The ingredient '#{@ingredient.name}' was deleted"]
      redirect_to ingredients_path
    else
      flash[:warning]= ["Something went wring.", "We were unable to delete the ingredient '#{@ingredient.name}' at this time."]
      redirect_to ingredients_path
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def set_ingredient
    @ingredient = Ingredient.find params[:id]
  end

  def require_admin
    if !logged_in? || !current_chef.admin?
      flash[:danger] = ["Invalid","Only administrators can edit or delete ingredients"]
      redirect_to recipes_path
    end
  end
end
