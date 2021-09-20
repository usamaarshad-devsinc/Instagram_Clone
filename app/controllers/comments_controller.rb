# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_comment, only: %i[edit update destroy]
  after_action :verify_authorized, only: %i[edit update destroy]

  def create
    post_id = params[:post_id]
    text = comments_params[:text]
    @comment = Comment.new(text: text, post_id: post_id)
    @comment.account = current_account
    if @comment.save
      redirect_to post_path(@comment.post), notice: 'Comment was successfuly posted.'
    else
      redirect_to post_path(@comment.post), notice: 'Some errors occur in commenting this post.'
    end
  end

  def edit; end

  def update
    if @comment.update(comments_params)
      redirect_to post_path(@comment.post), notice: 'Comment was successfuly updated.'
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to post_path(@comment.post), notice: 'Comment was successfuly deleted.' if @comment.destroy
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
