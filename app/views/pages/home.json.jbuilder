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
