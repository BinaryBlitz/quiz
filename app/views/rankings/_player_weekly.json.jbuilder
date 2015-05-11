json.partial! 'players/player', player: player
json.points topic ? player.weekly_topic_points(topic) : player.weekly_points
