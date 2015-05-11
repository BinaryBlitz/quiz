class TopicsController < ApplicationController
  def index
    @topics = Topic.where(visible: true)
  end

  def show
    @topic = Topic.find(params[:id])
  end
end
