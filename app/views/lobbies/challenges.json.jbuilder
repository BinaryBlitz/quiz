json.array! @lobbies do |lobby|
  json.extract! lobby, :id, :player_id, :topic_id
  json.name lobby.player.name
end
