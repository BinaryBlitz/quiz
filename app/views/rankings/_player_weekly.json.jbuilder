json.extract! player, :id, :name
json.points topic ? player.weekly_topic_points(topic) : player.weekly_points
