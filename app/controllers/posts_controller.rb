# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy show]
  before_action :set_account, only: %i[index home_page]
  before_action :authorization, only: %i[edit update destroy]

  after_action :verify_policy_scoped, only: :index
  after_action :verify_authorized, only: %i[edit update delete_image destroy]

  def index
    set_posts_and_stories
    @requests = Request.pending_requests_recieved(@account)
  end

  def home_page
    @account.followees
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
    if @post.update!(posts_params)
      flash[:notice] = 'Post was successfuly updated.'
      redirect_to @post
    else
      flash[:notice] = @post.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    return unless @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfuly deleted.' }
      format.js
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
    @stories = [].concat @account.stories
    requests = Request.where(sender: @account, status: 'accepted')
    requests.each do |req|
      @stories.concat(req.recipient.stories)
    end
  end

  def set_post
    flash[:notice] = ''
    @post = Post.find_by(id: params[:id])
  end

  def set_account
    @account = current_account
  end

  def authorization
    authorize @post
  end
end
