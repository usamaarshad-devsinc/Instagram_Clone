class StoriesController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    @story = current_account.stories.create(description: story_params)
    render @story
  end

  def show
  end

  private

  def story_params
    params.require(:story).permit(:description)
  end
end
