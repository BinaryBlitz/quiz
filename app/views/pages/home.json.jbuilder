json.featured_topics do
  json.array! @featured_topics do |topic|
    json.extract! topic, :id, :name
    json.points current_player.topic_points(topic)
  end
end

json.friends_favorite_topics do
  json.array! @friends_favorite_topics do |topic|
    json.extract! topic, :id, :name
    json.points current_player.topic_points(topic)
  end
end

json.favorite_topics do
  json.array! @favorite_topics do |topic|
    json.extract! topic, :id, :name
    json.points current_player.topic_points(topic)
  end
end

json.challenges do
  json.array! @challenges do |lobby|
    json.extract! lobby, :id, :player_id, :topic_id
    json.topic lobby.topic.name
    json.extract! lobby.player, :name, :avatar_url
  end
end

json.challenged do
  json.array! @challenged do |lobby|
    json.extract! lobby, :id, :player_id, :topic_id
    json.topic lobby.topic.name
    json.extract! lobby.player, :name, :avatar_url
  end
end
