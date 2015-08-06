json.array! @lobbies do |lobby|
  json.extract! lobby, :id, :player_id, :topic_id
  json.extract! lobby.player, :username, :avatar_url
end
