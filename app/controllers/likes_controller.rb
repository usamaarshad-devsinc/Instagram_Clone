# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    if already_liked?
      unlike_it
    else
      like_it
    end
    @likes = Like.where(post_id: params[:post_id]).count
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
    flash[:notice] = 'Successfully unliked.'
    Like.where(account_id: current_account.id, post_id: params[:id]).first.destroy
    @post = Post.find(params[:id])
    @likes = Like.where(post_id: params[:id]).count
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

  def unlike_it
    destroy
  end
end
