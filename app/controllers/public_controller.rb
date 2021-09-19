# frozen_string_literal: true

class PublicController < ApplicationController
  include PublicHelper
  # def homepage
  #   @user = current_account
  #   Rails.logger.debug "current user: #{@user.email}", @user.posts
  #   @posts = [].concat @user.posts
  #   @stories = [].concat @user.stories
  #   requests = Request.where(sender: @user, status: 'accepted')
  #   requests.each do |req|
  #     Rails.logger.debug req.recipient.posts
  #     @posts.concat(req.recipient.posts)
  #     @stories.concat(req.recipient.stories)
  #   end
  #   @requests = Request.where(recipient_id: current_account.id, status: 'pending')
  # end

  def search
    username = params[:username]
    @results = Account.search(username, match_mode: :any)
    # @results = search_friends(username)
    # respond_to do
    #   format.js
    # end
  end

  def profile
    @account = Account.find(params[:account])
  end

  private

  def pending_requests; end
end
