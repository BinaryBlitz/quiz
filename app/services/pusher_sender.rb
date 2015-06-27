class PusherSender
  def initialize(*players_ids)
    @players_ids = players_ids
  end

  def start_game
    @players_ids.each { |id| start_game_for_player(id) }
  end

  private

  def start_game_for_player(player_id)
    Pusher.trigger("player-session-#{player_id}", 'game-start', {})
    Rails.logger.debug "#{Time.zone.now}: Game start event sent to player #{player_id}."
  end
end
