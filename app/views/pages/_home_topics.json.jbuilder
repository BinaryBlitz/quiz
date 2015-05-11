json.array! topics do |topic|
  json.partial! 'topics/topic', topic: topic
  json.category topic.category.name
  json.points current_player.topic_points(topic)
end
