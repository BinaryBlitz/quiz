json.array! topics do |topic|
  json.extract! topic, :id, :name
  json.category topic.category.name
  json.points current_player.topic_points(topic)
end
