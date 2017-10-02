class LikesController < ApplicationController
  before_action :require_user

  def create
    recipe = Recipe.find(params[:recipe_id])
    if recipe.likes.where(chef_id: current_chef.id).exists?
      flash[:danger]  = ["Error","Like already exists"]
      redirect_back fallback_location: recipe
      return
    end
    like = recipe.likes.build(chef_id: current_chef.id)
    # redirect_to recipe_path(recipe)
    if like.save
      message = recipe.likes.count.to_s + ' '+'like'.pluralize(recipe.likes.count)
      ActionCable.server.broadcast("likes", {message: message, recipe_id: recipe.id})
      LikesButtonChannel.broadcast_to(
        current_chef,
        button: render_dislike(like),
        recipe_id: recipe.id
      )
    end
  end

  def destroy
    like = Like.find(params[:id])
    recipe = like.recipe
    if like.recipe_id != recipe.id || like.chef_id != current_chef.id
      flash[:danger]  = ["Error","Invalid operation"]
      redirect_back fallback_location: recipe
      return
    end
    like.destroy!
    message = recipe.likes.count.to_s + ' '+'like'.pluralize(recipe.likes.count)
    ActionCable.server.broadcast("likes", {message: message, recipe_id: recipe.id})
    LikesButtonChannel.broadcast_to(
      current_chef,
      button: render_like_form(recipe),
      recipe_id: recipe.id
    )
  end

  private

  def render_like_form recipe
    render(partial: 'likes/like_form', locals: { recipe: recipe})
  end

  def render_dislike like
    render(partial: 'likes/dislike', locals: { like: like})
  end
end
