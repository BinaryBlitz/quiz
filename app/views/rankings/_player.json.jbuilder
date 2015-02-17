json.extract! player, :id, :name
json.points topic ? player.topic_points(topic) : player.points
