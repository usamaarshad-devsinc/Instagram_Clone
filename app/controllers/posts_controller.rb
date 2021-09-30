# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy show destroy_like] # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :set_post_from_post_id, only: %i[delete_image create_like]
  before_action :authorization, only: %i[edit update destroy] # rubocop:disable Rails/LexicallyScopedActionFilter

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
    @post.destroy ? respond_to_block(root_path) : flash[:notice] = @post.errors.full_messages
  end

  def show
    @comments = @post.comments
  end

  def delete_image
    if @post.nil?
      render_error('Post')
    else
      authorize @post, :update?
      @index = params[:id]
      @post.images[@index].purge
    end
  end

  def create_like
    like_it
    @likes = Like.total_likes_on_post(params[:post_id])
    @post.nil? ? render_error('Post') : respond_to_block(root_path)
  end

  def destroy_like
    flash[:notice] = 'Successfully unliked.'
    like = Like.find_by(account_id: current_account.id, post_id: params[:id]).destroy
    like.destroy if authorize like, :destroy?
    @post.nil? ? render_error('Post') : @likes = Like.total_likes_on_post(params[:id])
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
    @stories = policy_scope(Story)
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
    like = Like.new(account_id: current_account.id, post_id: params[:post_id])
    authorize like, :create?
    flash[:notice] = like.save ? 'Post was successfuly liked.' : like.errors.full_messages
  end

  def set_post_from_post_id
    @post = Post.find_by(id: params[:post_id])
    render_error('Post') if @post.nil?
  end
end
