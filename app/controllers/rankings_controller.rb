class RankingsController < ApplicationController
  before_action :set_topic
  before_action :set_category

  def index
    @leaderboard = Leaderboard.new(current_player, options)
  end

  private

  def options
    options = {}
    options[:topic] = @topic if @topic
    options[:category] = @category if @category
    options[:weekly] = true if weekly?
    options[:friends] = true if friends?
    options
  end

  def set_topic
    @topic = Topic.find(params[:topic_id]) if params[:topic_id].present?
  end

  def set_category
    @category = Category.find(params[:category_id]) if params[:category_id].present?
  end

  def weekly?
    params[:weekly]
  end

  def friends?
    params[:friends]
  end
end
