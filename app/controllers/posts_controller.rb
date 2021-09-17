# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = current_account
    load_posts_and_stories
    @requests = Request.where(recipient_id: @user.id, status: 'pending')
  end

  def home_page
    @account = current_account
    @account.followees
  end

  def new
    @post = Post.new
  end

  def create
    # description = posts_params[:description]
    @post = current_account.posts.new(posts_params)
    if @post.save
      flash[:notice] = 'Post was successfuly created.'
      redirect_to @post
    else
      flash[:notice] = @post.errors.messages[:base].to_s
      redirect_to new_post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update!(posts_params)
      redirect_to @post, notice: 'Post was successfuly updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    redirect_to root_path, notice: 'Post was successfuly deleted.' if @post.destroy
  end

  def show
    Rails.logger.debug params
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  private

  def posts_params
    # puts params
    params.require(:post).permit(:description, images: [])
  end

  def load_posts_and_stories
    @posts = [].concat @user.posts
    @stories = [].concat @user.stories
    requests = Request.where(sender: @user, status: 'accepted')
    requests.each do |req|
      Rails.logger.debug req.recipient.posts
      @posts.concat(req.recipient.posts)
      @stories.concat(req.recipient.stories)
    end
  end
end
