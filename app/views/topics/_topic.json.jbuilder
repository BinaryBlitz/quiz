json.extract! topic, :id, :name, :price
json.points current_player.topic_points(topic)
