# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy show]
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
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Post was successfuly deleted.' }
        format.js
      end
    else
      flash[:notice] = @post.errors.full_messages
    end
  end

  def show
    @comments = @post.comments
  end

  def delete_image
    @post = Post.find_by(id: params[:post_id])
    authorize @post
    @index = params[:id].to_i
    @post.images[@index].purge
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
  end

  def authorization
    authorize @post
  end
end
