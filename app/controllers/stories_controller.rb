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
      redirect_to @story
    else
      flash[:notice] = 'Some errors occur in creating this story.'
      flash[:notice] += @story.errors.messages[:base].to_s
      redirect_to new_story_path(@story)
    end
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
