class StoriesController < ApplicationController
  def index
    @feature = Feature.find(params[:feature_id])
    @stories = @feature.stories
  end
end
