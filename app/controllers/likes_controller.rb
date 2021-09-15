class LikesController < ApplicationController

  def create
    if already_liked?
      unlike_it
    else
      like_it
    end
  end

  def destroy
    flash[:notice] = "Successfully unliked."
    Like.where(account_id: current_account.id, post_id: params[:post_id]).first.destroy
    redirect_to controller: :public, action: :homepage, notice: 'Post was successfuly unliked.'
  end

  private

  def already_liked?
    Like.exists?(account_id: current_account.id, post_id: params[:post_id])
  end

  def like_it
    post_id = params[:post_id]
    like = Like.new(account_id: current_account.id, post_id: post_id)
    if like.save
    flash[:notice] = "Post was successfuly liked."
    redirect_to controller: :public, action: :homepage, notice: 'Post was successfuly liked.'
    else
    flash[:notice] = "Some errors occur in liking this post."
    redirect_to controller: :public, action: :homepage, notice: 'Some errors occur in liking this post.'
    end
  end

  def unlike_it
    destroy
  end
end
