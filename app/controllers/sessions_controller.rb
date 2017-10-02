class SessionsController < ApplicationController

  def new
  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      cookies.signed[:chef_id] = chef.id
      flash[:success] = ["Signed in!","Welcome, chef #{chef.name}"]
      redirect_to chef_path(chef)
    else
      flash.now[:danger] = ["Not Authenticated:","The email or password are invalid"]
      render 'new'
    end
  end

  def destroy
    if session[:chef_id]
      session[:chef_id] = nil
      cookies.signed[:chef_id] = nil
      @current_chef = nil
      flash[:info] = ["Signed out successfully",""]
      redirect_to root_path
    else
      flash[:danger] = ["Not logged in",""]
      redirect_to root_path
    end
  end

end
