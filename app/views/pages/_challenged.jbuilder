json.array! lobbies do |lobby|
  json.extract! lobby, :id, :player_id, :topic_id
  json.topic lobby.topic.name
  json.category lobby.topic.category.name
  json.extract! lobby.player, :name, :avatar_url

  if lobby.game_session.closed
    json.results do
      json.host do
        json.partial! 'players/player', player: lobby.game_session.host
        json.extract! lobby.game_session.host, :multiplier
        json.points lobby.game_session.host.topic_points(lobby.topic)
      end
      json.opponent do
        json.partial! 'players/player', player: lobby.game_session.opponent
        json.extract! lobby.game_session.opponent, :multiplier
        json.points lobby.game_session.opponent.topic_points(lobby.topic)
      end
      json.host_points lobby.game_session.host_points
      json.opponent_points lobby.game_session.opponent_points
    end
  end
end
