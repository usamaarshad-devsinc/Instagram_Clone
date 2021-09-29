# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy show destroy_like]
  before_action :set_post_from_post_id, only: %i[delete_image create_like]
  before_action :authorization, only: %i[edit update destroy]

  def index
    set_posts_and_stories
    @requests = Request.pending_requests_recieved(current_account)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_account.posts.new(posts_params)
    authorization
    if @post.save
      flash[:notice] = 'Post was successfuly created.'
      redirect_to @post
    else
      flash[:notice] = @post.errors.full_messages
      redirect_to new_post_path(@post)
    end
  end

  def edit; end

  def update
    if @post.update(posts_params)
      flash[:notice] = 'Post was successfuly updated.'
      redirect_to @post
    else
      flash[:notice] = @post.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      respond_to_block
    else
      flash[:notice] = @post.errors.full_messages
    end
  end

  def show
    @comments = @post.comments
  end

  def delete_image
    render_error('Post') if @post.nil?
    authorize @post
    @index = params[:id].to_i
    @post.images[@index].purge
  end

  def create_like
    like_it
    @likes = Like.total_likes_on_post(params[:post_id])
    render_error('Post') if @post.nil?
    respond_to_block
  end

  def destroy_like
    flash[:notice] = 'Successfully unliked.'
    Like.find_by(account_id: current_account.id, post_id: params[:id]).destroy
    render_error('Post') if @post.nil?
    @likes = Like.total_likes_on_post(params[:id])
  end

  def already_liked?
    Like.exists?(account_id: current_account.id, post_id: params[:post_id])
  end

  private

  def posts_params
    params.require(:post).permit(:description, images: [])
  end

  def set_posts_and_stories
    @posts = policy_scope(Post)
    @stories = [].concat current_account.stories
    requests = Request.where(sender: current_account, status: 'accepted')
    requests.each do |req|
      @stories.concat(req.recipient.stories)
    end
  end

  def set_post
    flash[:notice] = ''
    @post = Post.find_by(id: params[:id])
    render_error('Post') if @post.nil?
  end

  def authorization
    authorize @post
  end

  def like_it
    post_id = params[:post_id]
    like = Like.new(account_id: current_account.id, post_id: post_id)
    flash[:notice] = if like.save
                       'Post was successfuly liked.'
                     else
                       like.errors.full_messages
                     end
  end

  def respond_to_block
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def set_post_from_post_id
    @post = Post.find_by(id: params[:post_id])
  end
end
