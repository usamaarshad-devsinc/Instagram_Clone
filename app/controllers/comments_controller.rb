class CommentsController < ApplicationController

  def create
    post_id = params[:post_id]
    text = comments_params[:text]
    comment = Comment.new(text: text, post_id: post_id)
    comment.account = current_account
    if comment.save
      redirect_to controller: :public, action: :homepage, notice: 'Post was successfuly liked.'
    else
      redirect_to controller: :public, action: :homepage, notice: 'Some errors occur in commenting this post.'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comments_params)
      redirect_to controller: :public, action: :homepage, notice: 'Comment was successfuly updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to controller: :public, action: :homepage, notice: 'Comment was successfuly deleted.'
    end
  end

  private

  def comments_params
    # puts params
    params.require(:comment).permit(:text)
  end

end

