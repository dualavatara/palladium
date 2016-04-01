class StoriesController < ApplicationController
  def index
    if params[:feature_id]
      @feature = Feature.find(params[:feature_id])
      @stories = @feature.stories
    elsif params[:project_id]
      @project = Project.find(params[:project_id])
      @stories = @project.stories
    else
      @project = current_user.current_project
      @stories = @project.stories
    end

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

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to feature_stories_path(@story.feature.id)
  end

  private

  def story_params
    params.require(:story).permit(:name, :desc, :actor_id)
  end
end
