class RankingsController < ApplicationController
  before_action :find_topic

  def general
    top_players = Player.all.sort_by(&:points).reverse

    @rankings = top_players.first(20)

    @current_index = top_players.index(current_player)
    @player_rankings = top_players[@current_index - 5..@current_index + 5] if @current_index >= 20
    render formats: :json
  end

  def weekly
    #
  end

  private

  def rankings_params
    params.permit(:topic_id)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  rescue
    nil
  end
end
