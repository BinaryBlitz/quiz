json.extract! topic, :id, :name, :price, :played_count
json.points current_player.topic_points(topic)
