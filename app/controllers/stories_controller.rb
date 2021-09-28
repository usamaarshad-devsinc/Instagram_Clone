# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :set_story, only: %i[show destroy]

  def index
    @stories = policy_scope(Story)
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_account.stories.new(story_params)
    authorize @story
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
    if @story.destroy
      respond_to do |format|
        format.html { redirect_to root_path, flash[notice: 'Story was successfuly deleted.'] }
        format.js
      end
    else
      flash[:notice] = @story.errors.full_messages
    end
  end

  private

  def set_story
    @story = Story.find_by(id: params[:id])
    render_error('Story') if @story.nil?
  end

  def story_params
    params.require(:story).permit(:description, :image)
  end
end
