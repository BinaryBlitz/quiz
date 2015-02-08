class TopicsController < ApplicationController
  def index
    @topics = Topic.where(visible: true)
    render formats: :json
  end

  def show
    @topic = Topic.find(params[:id])
    render formats: :json
  end
end
