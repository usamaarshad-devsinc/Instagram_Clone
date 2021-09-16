class PostsController < ApplicationController

  def index
    @user = current_account
    puts "current user: #{@user.email}", @user.posts
    @posts = [].concat @user.posts
    @stories = [].concat @user.stories
    requests = Request.where(sender: @user, status: 'accepted')
    requests.each do |req|
      puts req.recipient.posts
      @posts.concat(req.recipient.posts)
      @stories.concat(req.recipient.stories)
    end
    @requests = Request.where(recipient_id: current_account.id, status: 'pending')
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
    if @post.destroy
      redirect_to root_path, notice: 'Post was successfuly deleted.'
    end
  end

  def show
    puts params
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  private

  def posts_params
    # puts params
    params.require(:post).permit(:description, images: [])
  end
end
