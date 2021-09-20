# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :load_post, only: %i[edit update destroy show]
  before_action :load_account, only: %i[index homepage] # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :authorization, only: %i[edit update destroy]

  after_action :verify_policy_scoped, only: :index
  after_action :verify_authorized, only: %i[edit update destroy]

  def index
    load_posts_and_stories
    @requests = Request.where(recipient_id: @account.id, status: 'pending')
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
      flash[:notice] = @post.errors.messages[:base]
      redirect_to new_post_path(@post)
    end
  end

  def edit; end

  def update
    if @post.update!(posts_params)
      flash[:notice] = 'Post was successfuly updated.'
      redirect_to @post
    else
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

  private

  def posts_params
    params.require(:post).permit(:description, images: [])
  end

  def load_posts_and_stories
    @posts = policy_scope(Post)
    # @posts = [].concat @account.posts
    @stories = [].concat @account.stories
    requests = Request.where(sender: @account, status: 'accepted')
    requests.each do |req|
      # @posts.concat(req.recipient.posts)
      @stories.concat(req.recipient.stories)
    end
  end

  def load_post
    @post = Post.find(params[:id])
  end

  def load_account
    @account = current_account
  end

  def authorization
    authorize @post
  end
end
