class FavoritesController < ApplicationController
  before_action :require_sign_in

  def create
    post = Post.find(params[:post_id])
    #find the post we want to favorite using the post_id in params
    favorite = current_user.favorites.build(post: post)
    #create a favorite for the current_user, passing in the post to establish associations for the user, post, and favorite.

    if favorite.save
      flash[:notice] = "Post favorited."
    else
      flash[:alert] = "Favoriting failed."
    end

    redirect_to [post.topic, post]
  end


  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
    else
      flash[:alert] = "Unfavoriting failed."
    end
      redirect_to [post.topic, post]
  end

end
