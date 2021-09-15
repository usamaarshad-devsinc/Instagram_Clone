class PostsController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @posts = @account.posts
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
      flash[:notice] = 'Some errors occur in creating this post.'
      flash[:notice] += @post.errors.messages[:base].to_s
      redirect_to new_post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    puts posts_params
    if @post.update!(posts_params)
      redirect_to @post, notice: 'Post was successfuly updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to controller: :public, action: :homepage, notice: 'Post was successfuly deleted.'
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
