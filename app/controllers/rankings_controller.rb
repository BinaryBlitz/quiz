class RankingsController < ApplicationController
  before_action :set_topic, only: :topic
  before_action :set_category, only: :category

  def general
    if weekly?
      @rankings = Player.order_by_weekly_points(20)
      @position = Player.position_weekly(current_player)
      @player_rankings = Player.order_by_weekly_points(11).offset(@position - 5) if @position > 20
    else
      @rankings = Player.order_by_points(20)
      @position = Player.position_general(current_player)
      @player_rankings = Player.order_by_points(11).offset(@position - 5) if @position > 20
    end
    render :rankings
  end

  def topic
    if weekly?
      set_up_rankings(Player.order_by_weekly_topic(@topic))
    else
      set_up_rankings(Player.order_by_topic(@topic))
    end
    render :rankings
  end

  def category
    if weekly?
      set_up_rankings(Player.order_by_weekly_category(@category))
    else
      set_up_rankings(Player.order_by_category(@category))
    end
    render :rankings
  end

  private

  def set_topic
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def set_category
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

  def weekly?
    params.key?(:weekly)
  end

  helper_method :weekly?
end
