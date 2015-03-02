class RankingsController < ApplicationController
  before_action :find_topic, only: [:general, :weekly]
  before_action :find_category, only: [:general_by_category, :weekly_by_category]

  def general
    top_players = @topic ? Player.order_by_topic(@topic) : Player.order_by_points
    set_up_rankings(top_players)
    render formats: :json
  end

  def weekly
    top_players = @topic ? Player.order_by_weekly_topic(@topic) : Player.order_by_weekly_points
    set_up_rankings(top_players)
    render formats: :json
  end

  def general_by_category
    top_players = Player.order_by_category(@category)
    set_up_rankings(top_players)
    render formats: :json, template: 'rankings/category_rankings'
  end

  def weekly_by_category
    top_players = Player.order_by_weekly_category(@category)
    set_up_rankings(top_players)
    @weekly = true
    render formats: :json, template: 'rankings/category_rankings'
  end

  private

  def rankings_params
    params.permit(:topic_id)
  end

  def find_topic
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def player_rankings(players)
    # Five positions before and after current player
    players.offset(@position - 5).limit(11)
  end

  def current_player_range
    (@current_position - 5)..(@current_position + 5)
  end

  def set_up_rankings(top_players)
    @rankings = top_players.limit(Player::TOP_SIZE)
    @position = top_players.index(current_player)
    @player_rankings = player_rankings(top_players) if @position.to_i >= Player::TOP_SIZE
  end
end
