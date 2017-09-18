class ChefsController < ApplicationController

  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: :destroy

  def index
    @chefs = Chef.paginate(page: params[:page], per_page:5)
  end

  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page:5)
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      cookies.signed[:chef_id] = @chef.id
      flash[:success]= ["Signed up!", "Your account was successfully created!"]
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def new
    @chef = Chef.new
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success]= ["Updated!", "Chef #{@chef.name} was updated successfully!"]
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end

  def destroy
    if !@chef.admin?
      if @chef.destroy
        flash[:warning]= ["Done!", "Chef #{@chef.name} and all it's recipes have been deleted."]
        redirect_to chefs_path
      else
        flash[:danger]= ["Error", "Chef #{@chef.name} couldn't be deleted."]
        redirect_to chefs_path
      end
    else
      flash[:danger]= ["Invalidation", "Chef #{@chef.name} is an administrator and as such his/her account can not be destroyed."]
      redirect_to chefs_path
    end
  end

  private
  def chef_params
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

  def require_same_user
    if current_chef != @chef && !current_chef.admin?
      flash[:danger] = ["Invalid","You can only edit or delete your own account"]
      redirect_to chefs_path
    end
  end

  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger] = ['Invalid', 'Only an administrator can perform that action']
      redirect_to root_path
    end
  end
end
