json.array! @lobbies do |lobby|
  json.extract! lobby, :id, :topic_id
  json.player_id lobby.game_session.opponent_id
  json.extract! lobby.game_session.opponent, :username, :avatar_url
end
