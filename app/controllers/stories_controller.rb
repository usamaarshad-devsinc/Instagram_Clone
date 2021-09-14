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
    @story = current_account.stories.create(story_params)
    redirect_to @story
  end

  def show
    @story = Story.find(params[:id])
  end

  def destroy
    @story = Story.find(params[:id])
    if @story.destroy
      redirect_to controller: :public, action: :homepage, notice: 'Story was successfuly deleted.'
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    puts story_params
    if @story.update!(story_params)
      redirect_to @story, notice: 'Story was successfuly updated.'
    else
      render 'edit'
    end
  end

  private

  def story_params
    params.require(:story).permit(:description,:image)
  end
end
