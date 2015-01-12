class Admin::TopicsController < ApplicationController
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @questions = Question.where(topic: @topic)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.expires_at = Date.new(
      topic_params['expires_at(1i)'].to_i,
      topic_params['expires_at(2i)'].to_i,
      topic_params['expires_at(3i)'].to_i) if topic_params['expires_at(1i)']

    if @topic.save
      redirect_to [:admin, @topic], notice: 'Topic was successfully created.'
    else
      puts params
      puts @topic.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to [:admin, @topic], notice: 'Topic was successfully updated.'
    else
      render :new
    end
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :visible, :expires_at, :price, :price,
      :played_count, :category_id)
  end
end
