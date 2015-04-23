json.array! lobbies do |lobby|
  json.extract! lobby, :id, :player_id, :topic_id
  json.topic lobby.topic.name
  json.category lobby.topic.category.name
  json.extract! lobby.player, :name, :avatar_url
end
