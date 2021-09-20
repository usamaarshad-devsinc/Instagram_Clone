# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_comment, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def create
    @post = Post.find(params[:post_id])
    text = comments_params[:text]
    @comment = Comment.new(text: text, post_id: @post.id, account_id: current_account.id)
    # @comment.account = current_account
    flash[:notice] = if @comment.save
                       'Comment was successfuly posted.'
                     else
                       'Some errors occur in commenting this post.'
                     end
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post) }
      format.js
    end
  end

  def edit; end

  def update
    if @comment.update(comments_params)
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post), notice: 'Comment was successfuly updated.' }
        format.js
      end
    else
      render 'edit'
    end
  end

  def destroy
    flash[:notice] = @comment.destroy ? 'Comment was successfuly deleted.' : @comment.errors.full_messages
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post) }
      format.js
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end

  def load_comment
    @comment = Comment.find(params[:id])
    authorize @comment
  end
end
