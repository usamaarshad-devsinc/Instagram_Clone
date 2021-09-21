# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    like_it
    @likes = Like.total_likes_on_post(params[:post_id])
    @post = Post.find_by(params[:post_id])
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    flash[:notice] = 'Successfully unliked.'
    Like.where(account_id: current_account.id, post_id: params[:id]).first.destroy
    @post = Post.find(params[:id])
    @likes = Like.total_likes_on_post(params[:id])
  end

  def already_liked?
    Like.exists?(account_id: current_account.id, post_id: params[:post_id])
  end

  private

  def like_it
    post_id = params[:post_id]
    like = Like.new(account_id: current_account.id, post_id: post_id)
    flash[:notice] = if like.save
                       'Post was successfuly liked.'
                     else
                       'Some errors occur in liking this post.'
                     end
  end
end
