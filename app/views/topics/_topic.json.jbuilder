json.extract! topic, :id, :name
json.background_url topic.category.background_url
json.points current_player.topic_points(topic)
json.visible current_player.topics_unlocked?
