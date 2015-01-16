class TopicsController < ApplicationController
  before_action :restrict_access

  def index
    @topics = Topic.all
    render formats: :json
  end

  def show
    @topic = Topic.find(params[:id])
    render formats: :json
  end
end
