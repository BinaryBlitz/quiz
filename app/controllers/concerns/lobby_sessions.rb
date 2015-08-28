module LobbySessions
  extend ActiveSupport::Concern

  private

  # Opponent found, create online session
  def create_online_session_with_lobby(opponent_lobby)
    @session = GameSession.create!(
      topic: @lobby.topic,
      host: current_player,
      opponent: opponent_lobby.player,
      offline: false)
    @session.generate
    @session.lobbies << [@lobby, opponent_lobby]
    @lobby.close
  end

  # Opponent not found, create offline session with given params
  def create_offline_session
    @session = GameSession.create!(
      topic: @lobby.topic,
      host: current_player,
      offline: true)
    @session.generate
    @lobby.close
  end
end
