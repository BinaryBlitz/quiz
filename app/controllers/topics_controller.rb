class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    render formats: :json
  end

  def show
    @topic = Topic.find(params[:id])
    render formats: :json
  end
end
