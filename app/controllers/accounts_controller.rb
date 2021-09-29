# frozen_string_literal: true

class AccountsController < ApplicationController
  include AccountsHelper

  def search
    username = params[:username]
    # @results = Account.search(username, match_mode: :any)
    @results = search_friends(username)
  end

  def profile
    @account = Account.find_by(id: params[:account])
    render_error('Profile') if @account.nil?
  end

  private

  def pending_requests; end
end