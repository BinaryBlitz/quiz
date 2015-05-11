json.array! lobbies do |lobby|
  json.extract! lobby, :id, :player_id
  json.topic do
    json.partial! 'topics/topic', topic: lobby.topic
    json.category lobby.topic.category.name
  end
  json.extract! lobby.player, :name, :username, :avatar_url
end
