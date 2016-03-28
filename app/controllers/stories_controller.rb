class StoriesController < ApplicationController
  def index
    @feature = Feature.find(params[:feature_id])
    @stories = @feature.stories
  end

  def new
    @feature = Feature.find(params[:feature_id])
    @story = Story.new
  end

  def create
    @feature = Feature.find(params[:feature_id])
    @story = Story.new(story_params)
    @story.feature = @feature
    @story.actor = Actor.find(story_params[:actor_id]) unless story_params[:actor_id].blank?

    if @story.save
      redirect_to feature_stories_path(@feature.id)
    else
      render :new
    end
  end

  private

  def story_params
    params.require(:story).permit(:name, :desc, :actor_id)
  end
end
