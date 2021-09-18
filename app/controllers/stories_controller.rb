# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :load_story, only: %i[show destroy]
  after_action :verify_policy_scoped, only: :index
  after_action :verify_authorized, only: :destroy

  def index
    @stories = policy_scope(Story)
    # @stories = [].concat current_account.stories
    # requests = current_account.requests_sent.where(status: 'accepted')
    # requests.each do |req|
    #   @stories.concat(req.recipient.stories)
    # end
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_account.stories.new(story_params)
    if @story.save
      flash[:notice] = 'Post was successfuly created.'
      redirect_to root_path
    else
      flash[:notice] = @story.errors.full_messages
      redirect_to new_story_path(@story)
    end
  end

  def show; end

  def destroy
    authorize @story
    redirect_to root_path, flash[notice: 'Story was successfuly deleted.'] if @story.destroy
  end

  private

  def load_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:description, :image)
  end
end
