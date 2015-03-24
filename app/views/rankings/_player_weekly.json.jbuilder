json.extract! player, :id, :name, :avatar_url
json.points topic ? player.weekly_topic_points(topic) : player.total_points
