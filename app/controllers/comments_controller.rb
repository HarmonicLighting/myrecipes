class CommentsController < ApplicationController

  before_action :require_user
  before_action :set_comment, except:[:create]
  before_action :require_same_user, except:[:create]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      flash[:success] =  ["Comment created",""]
      redirect_to recipe_path @recipe
    else
      flash[:danger]  = ["Error","Comment was not created"]
      redirect_back fallback_location: @recipe
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] =  ["Comment updated",""]
      redirect_to recipe_path @comment.recipe
    else
      flash[:danger]  = ["Error","Comment was not updated"]
      render :edit
    end
  end

  def destroy
    recipe = @comment.recipe
    if @comment.destroy
      flash[:info]= ["Confirmation", "The comment was deleted"]
      redirect_to recipe_path recipe
    else
      flash[:warning]= ["Something went wring.", "We were unable to delete the comment at this time."]
      redirect_to recipe_path recipe
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_same_user
    if current_chef != @comment.chef && !current_chef.admin?
      flash[:danger] = ["Invalid","You can only edit or delete your own comments"]
      redirect_to recipe_path @recipe
    end
  end
end
