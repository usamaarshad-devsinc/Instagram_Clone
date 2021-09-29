# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = Comment.new(text: comments_params[:text], post_id: params[:post_id], account_id: current_account.id)
    flash[:notice] = @comment.save ? 'Comment was successfuly posted.' : 'Some errors occur in commenting this post.'
    respond_to_block
  end

  def edit; end

  def update
    @comment.update(comments_params) ? respond_to_block : render('edit')
  end

  def destroy
    flash[:notice] = @comment.destroy ? 'Comment was successfuly deleted.' : @comment.errors.full_messages
    respond_to_block
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    @comment.nil? ? render_error('Comment') : authorize(@comment)
  end

  def respond_to_block
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post) }
      format.js
    end
  end
end
