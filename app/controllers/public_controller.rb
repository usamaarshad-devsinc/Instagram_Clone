class PublicController < ApplicationController
  include PublicHelper
  def homepage
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

  def search
    puts params
    @results = search_friends(params[:username])
    puts @results
    @results
  end

  def profile
    puts params
    @account = Account.find(params[:account])
  end

  private

  def pending_requests()

  end
end
