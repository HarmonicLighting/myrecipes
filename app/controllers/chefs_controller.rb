class ChefsController < ApplicationController
  def index
    @chefs = Chef.all
  end

  def show
    @chef = Chef.find(params[:id])
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
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
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success]= ["Updated!", "Chef #{@chef.name} was updated successfully!"]
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end
  end

  def delete
  end

  private
  def chef_params
    params.require(:chef).permit(:name, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end
end
