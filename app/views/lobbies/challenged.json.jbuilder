json.array! @lobbies do |lobby|
  json.extract! lobby, :id, :topic_id
  json.player_id lobby.game_session.opponent_id
  json.name lobby.game_session.opponent.name
end
