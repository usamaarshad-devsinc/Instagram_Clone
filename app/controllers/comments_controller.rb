# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :authorization, only: %i[edit update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter

  def create
    @comment = current_account.comments.new(comments_params)
    authorization
    flash[:notice] = @comment.save ? 'Comment was successfuly posted.' : 'Some errors occur in commenting this post.'
    respond_to_block(post_path(@comment.post))
  end

  def update
    @comment.update(text: comments_params[:text]) ? respond_to_block(post_path(@comment.post)) : render('edit')
  end

  def destroy
    flash[:notice] = @comment.destroy ? 'Comment was successfuly deleted.' : @comment.errors.full_messages
    respond_to_block(post_path(@comment.post))
  end

  private

  def comments_params
    params.require(:comment).permit(:text).merge(params.permit(:post_id))
  end

  def set_comment
    @comment = current_account.comments.find_by(id: params[:id])
    @comment.nil? ? render_error('Comment') : authorize(@comment)
  end

  def authorization
    authorize @comment
  end
end
