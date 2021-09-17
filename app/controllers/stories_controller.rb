class StoriesController < ApplicationController

  def index
    @stories = [].concat current_account.stories
    requests = current_account.requests_sent.where(status: 'accepted')
    requests.each do |req|
      @stories.concat(req.recipient.stories)
    end
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

  def show
    @story = Story.find(params[:id])
  end

  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      redirect_to root_path, notice: 'Story was successfuly deleted.'
    end
  end

  private

  def story_params
    params.require(:story).permit(:description,:image)
  end
end
