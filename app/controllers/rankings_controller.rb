class RankingsController < ApplicationController
  before_action :find_topic

  def general
    top_players = @topic ? Player.order_by_topic(@topic) : Player.order_by_points

    @rankings = top_players.limit(Player::TOP_SIZE)
    @position = top_players.index(current_player)
    @player_rankings = player_rankings(top_players) if @position.to_i >= Player::TOP_SIZE

    render formats: :json
  end

  def weekly
    top_players = @topic ? Player.order_by_weekly_topic(@topic) : Player.order_by_weekly_points

    @rankings = top_players.limit(Player::TOP_SIZE)
    @position = top_players.index(current_player)
    @player_rankings = player_rankings(top_players) if @position.to_i >= Player::TOP_SIZE

    render formats: :json
  end

  private

  def rankings_params
    params.permit(:topic_id)
  end

  def find_topic
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def player_rankings(players)
    players.offset(@position - 5).limit(11)
  end

  def current_player_range
    (@current_position - 5)..(@current_position + 5)
  end
end
