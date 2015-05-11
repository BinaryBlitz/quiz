json.array! lobbies do |lobby|
  json.extract! lobby, :id, :player_id
  json.extract! lobby.player, :username, :avatar_url
  json.topic do
    json.extract! lobby.topic, :id, :name, :category_id
    json.category_name lobby.topic.category.name
  end

  if lobby.game_session.closed && lobby.game_session.offline?
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
