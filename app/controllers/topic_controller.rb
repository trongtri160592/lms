class TopicController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  def index
    @topics = Topic.all
	@topic = Topic.new
  end

  def new
    respond_to do |format|
      format.html{redirect_to '/quan-ly-chu-de'}
      format.js
    end
  end

  def create
	@topic = Topic.new(topic_params)
    if @topic.save
      @topics = Topic.all
      respond_to do |format|
        format.js
      end
    end
  end
  
  private
  def topic_params
	params.require(:topic).permit(:name, :description)
  end
end
